import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_darling_app/bloc/background_event.dart';
import 'package:my_darling_app/bloc/background_state.dart';
import 'package:my_darling_app/model/step_record_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState>{
  BackgroundBloc({required bool isRunning}) : super(BackgroundInitial(isRunning)){
   on<BackgroundStartService>(startService);
  }

  static const _workmanagerId = "notificationId";
  static const _workmanagerTime = Duration(seconds: 1);

  Future<void> startService( BackgroundEvent event, Emitter<BackgroundState> emit) async{
    checkPermission();
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await Workmanager().registerPeriodicTask(_workmanagerId, 'periodic', frequency: _workmanagerTime);
    emit(BackgroundStartSuccess(true));
  }
  
  @pragma('vm:entry-point')
  Future<void> callbackDispatcher() async {
    Workmanager().executeTask((task, inputData) async{
      if (kDebugMode) {
        print("task workmanager $task");
      }
      await Hive.initFlutter();
      Hive.registerAdapter(StepRecordDataAdapter());

      FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
      var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var settings = InitializationSettings(android: android);
      notificationsPlugin.initialize(settings);
      showNotificationWithSound(notificationsPlugin);
      return Future.value(true);
    });
  }

  void showNotificationWithSound(FlutterLocalNotificationsPlugin notificationsPlugin) async {
    var androidPlatformChannel = const AndroidNotificationDetails( 'your channel id',
        'your channel name', importance: Importance.high, priority: Priority.high);
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannel);
    await notificationsPlugin.show(1, "MyDarling", "Jangan Lupa untuk check in hari ini", platformChannelSpecifics);
  }

  Future<void> checkPermission() async {
    late final Map<Permission, PermissionStatus> status;
    status = await [Permission.activityRecognition, Permission.notification]
        .request();
    status.forEach((permission, status) {
      if (status.isGranted) {
      } else if (status.isDenied) {
        openAppSettings();
      } else {
        print('Permission not activate');
      }
    });
  }
}

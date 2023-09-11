import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:my_darling_app/model/step_record_data.dart';
import 'package:my_darling_app/page/splash_screen.dart';
import 'package:my_darling_app/pedometer_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const _workmanagerId = "notificationId";
const _workmanagerTime = Duration(minutes: 15);

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async{
    if (kDebugMode) {
      print("task workmanager $task");
    }
    initializeNotification();
    return Future.value(true);
  });
}


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(_workmanagerId, 'periodic', frequency: _workmanagerTime);

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(StepRecordDataAdapter());
  await Hive.openBox<StepRecordData>("recordLangkahBox");
  runApp(const MyApp());
}

void initializeNotification() {
  var initializationSettingAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher");
  var initializationSettings = InitializationSettings(android: initializationSettingAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  scheduleNotification();
}

void scheduleNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
      'repeating channel id', 'repeating channel name',
      channelDescription: 'repeating description');
  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(1, "MyDarling", "Jangan Lupa Masuk Aplikasi",notificationDetails);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PedometerProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

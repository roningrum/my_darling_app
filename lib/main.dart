import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:my_darling_app/model/step_record_data.dart';
import 'package:my_darling_app/page/splash_screen.dart';
import 'package:my_darling_app/pedometer_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  initializeNotification();

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
  await flutterLocalNotificationsPlugin.periodicallyShow(1, "MyDarling", "Jangan Lupa Masuk Aplikasi", RepeatInterval.everyMinute, notificationDetails ,androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
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

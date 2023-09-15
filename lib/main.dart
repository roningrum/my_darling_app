import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:my_darling_app/model/step_record_data.dart';
import 'package:my_darling_app/page/splash_screen.dart';
import 'package:my_darling_app/pedometer_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const String isolateName = 'isolate';
final ReceivePort port = ReceivePort();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  IsolateNameServer.registerPortWithName(port.sendPort,isolateName);

  AndroidAlarmManager.initialize();

  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(StepRecordDataAdapter());
  await Hive.openBox<StepRecordData>("recordLangkahBox");
  runApp(const MyApp());
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

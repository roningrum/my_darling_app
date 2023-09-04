import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_darling_app/page/splash_screen.dart';
import 'package:my_darling_app/pedometer_provider.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';


// const AndroidInitializationSettings initializationSettingsAndroid =
// AndroidInitializationSettings('ic_notification');

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);


sendData(){
  if (kDebugMode) {
    print("hello");
  }
}
@pragma('vm:entry-point')
void callbackDispatcher(){
  Workmanager().executeTask((task, inputData){
    sendData();
    return Future.value(true);
  });
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse response){});

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  // await Workmanager().registerPeriodicTask('workmanagerId', "hello", frequency: const Duration(seconds: 1));
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

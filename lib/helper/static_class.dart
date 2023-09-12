import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

Future<void> initialNotification() async{
  var initializationSettingAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher");
  var initializationSettings = InitializationSettings(android: initializationSettingAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}


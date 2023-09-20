import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static final _notificationPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(){
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );
    _notificationPlugin.initialize(initializationSettings);
  }

  static void displayNotification(String langkah) async{
    try{
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          'myDarling',
          'myDarling',
          channelDescription: 'getNotification',
          importance: Importance.high,
          priority: Priority.high,
          playSound: false,
          autoCancel: false,
          onlyAlertOnce: false,
          ongoing: true,
        )
      );
      await _notificationPlugin.show(1, "MyDarling", "Langkah $langkah", notificationDetails);

    } catch(e){
      rethrow;
    }
  }
}
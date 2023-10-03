import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  static final _notificationPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(){
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );
    _notificationPlugin.initialize(initializationSettings);
  }

  static void displayNotification(String langkah, String status) async{
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
          onlyAlertOnce: true,

          ongoing: true,
          channelShowBadge: false
        )
      );
      await _notificationPlugin.show(1, "MyDarling", "Langkah $langkah, Status $status", notificationDetails);

    } catch(e){
      rethrow;
    }
  }
}
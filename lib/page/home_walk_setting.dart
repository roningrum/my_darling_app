import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_darling_app/helper/static_class.dart';
import 'package:my_darling_app/main.dart';
import 'package:my_darling_app/theme/theme.dart';

class HomeWalkSetting extends StatefulWidget {
  const HomeWalkSetting({super.key});

  @override
  State<HomeWalkSetting> createState() => _HomeWalkSettingState();
}

class _HomeWalkSettingState extends State<HomeWalkSetting> {
  String isolateName = 'isolate';
  bool isActive = false;

  final port = ReceivePort();

  static SendPort? uiSendPort;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Notifikasi', style: title.copyWith(color: white)),
        backgroundColor: primaryBlueBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pengingat Harian', style: regular),
                ElevatedButton(onPressed: (){
                  _scheduleAlarmPeriodic();
                }, child: const Text('Pressed'),)
                // Switch(value: isActive, onChanged: (value){
                //   setState(() {
                //     isActive = value;
                //   });
                //   isActive ? _scheduleAlarmPeriodic() : stopAlarm();
                // }, activeColor: primaryRed)
              ],
            )
          ],
        ),
      ),
    );
  }

  //scheduled Alarm
  Future<void> _scheduleAlarmPeriodic() async{
    Duration duration = const Duration(minutes: 15);
    await AndroidAlarmManager.periodic(duration, 1, _periodiceNotification, rescheduleOnReboot: true, exact: true, wakeup: true);
  }

  void _periodiceNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'repeating channel id', 'repeating channel name',
        channelDescription: 'repeating description', importance: Importance.low);
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    if (kDebugMode) {
      print("Alarm Jalan");
    }
    await flutterLocalNotificationsPlugin.show(1, "MyDarling", "Jangan Lupa Masuk Aplikasi",notificationDetails);
  }

  void stopAlarm() async{
    await AndroidAlarmManager.cancel(1);
    await flutterLocalNotificationsPlugin.cancel(1);
  }
}
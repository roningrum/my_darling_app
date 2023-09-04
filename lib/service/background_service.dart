import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundService{

  Future<void>sendData() async{
    if (kDebugMode) {
      print("hello");
    }
  }

  @pragma('vm:entry-point')
  void callbackDispatcher() async{
    Workmanager().executeTask((task, inputData){
      sendData();
      return Future.value(true);
    });
  }

  Future<void> startServiceManager()async{
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await Workmanager().registerPeriodicTask('workmanagerId', "hello", frequency: const Duration(seconds: 1));
  }



}
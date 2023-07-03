import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class PedometerProvider with ChangeNotifier{
  int _stepCountToday = 0;

  final Stream<StepCount> _stepCountStream = Pedometer.stepCountStream;
  String _status = 'Standing';
  late  Box<int> stepBox;
  final Stream<PedestrianStatus> _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

  late PermissionStatus _permissionStatus = PermissionStatus.denied;

  initialize() async{
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    stepBox = await Hive.openBox('steps');
    checkPermission();
    notifyListeners();
  }

  //check Permission first
  void checkPermission() async{
    final statusPermission = await Permission.activityRecognition.request();
    _permissionStatus = statusPermission;
    if(_permissionStatus != PermissionStatus.denied){
      startListening();
      if (kDebugMode) {
          print("Permission running");
      }}
    else{
      // startListening();
      await Permission.activityRecognition.request();
      if (kDebugMode) {
        print("Check Permission");
      }
    }
    notifyListeners();
  }

  void startListening(){
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    notifyListeners();
  }

  void onStepCountError(error){
    if (kDebugMode) {
      print('onStepCountError: $error');
    }
    notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');

    _status = 'Cannot get status.';
    notifyListeners();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) async {
    print(event);
    _status = event.status;
    notifyListeners();
  }

  void onStepCount(StepCount event) async{
    int savedStepCountKey = 999999;
    int savedStepsCount = stepBox.get(savedStepCountKey, defaultValue: 0)!;
    int todayDayNo = Jiffy.now().dayOfYear;

    if (kDebugMode) {
      print('Last Day $todayDayNo');
    }

    if (event.steps < savedStepsCount) {
      savedStepsCount = 0;
      stepBox.put(savedStepCountKey, savedStepsCount);
    }

    int lastSavedDayKey = 888888;
    int lastSavedDay = stepBox.get(lastSavedDayKey, defaultValue: 0)!;

    if (lastSavedDay < todayDayNo) {
      lastSavedDay = todayDayNo;
      savedStepsCount = event.steps;

      stepBox
        ..put(lastSavedDayKey, lastSavedDay)
        ..put(savedStepCountKey, savedStepsCount);
    }
    _stepCountToday = event.steps - savedStepsCount;
    stepBox.put('today steps',_stepCountToday);

    notifyListeners();
  }

  String get pedestrianStatus => _status;
  String get pedestrianStepCount => _stepCountToday.toString();

}
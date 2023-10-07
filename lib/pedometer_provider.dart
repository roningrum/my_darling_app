import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_darling_app/notification_service.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import 'helper/session_manager.dart';

class PedometerProvider with ChangeNotifier {

  int _stepCountToday = 0;
  int _totalStepCount = 0;
  String _calorie = "0";
  String _distance = "0";

  bool isInitialized = false;

  final Stream<StepCount> _stepCountStream = Pedometer.stepCountStream;

  final sessionManager = SessionManager();
  final _networkRepo = NetworkRepo();

  String _status = 'Standing';

  final String storageKey = "pedometer";
  final int savedData = 1;

  late Timer _dailyResetTimer;
  late Box<int> stepBox;
  final Stream<PedestrianStatus> _pedestrianStatusStream =
      Pedometer.pedestrianStatusStream;

  initialize() async {
    stepBox = await Hive.openBox('steps');
    // await sessionManager.readStep(storageKey);
    // updateStep();
    checkPermission();
    notifyListeners();
  }

  Future<void> checkPermission() async {
    late final Map<Permission, PermissionStatus> status;
    status = await [Permission.activityRecognition, Permission.notification]
        .request();
    status.forEach((permission, status) {
      if (status.isGranted) {
        startDailyStepReset();
        startListening();
      } else if (status.isDenied) {
        openAppSettings();
      } else {
        print('Permission not activate');
      }
    });
    notifyListeners();
  }

  void startListening() {
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    notifyListeners();
  }


  void onStepCountError(error) {
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

  void stop() {
    _stepCountStream.listen(onStepCount).cancel();
    notifyListeners();
  }

  void onStepCount(StepCount event) async {
    int savedStepCountKey = 999999;
    int savedStepsCount = stepBox.get(savedStepCountKey, defaultValue: 0)!;
    int todayDayNo = Jiffy.now().dayOfYear;
    
    int lastSavedDayKey = 888888;
    int lastSavedDay = stepBox.get(lastSavedDayKey, defaultValue: 0)!;

    int updateStep = stepBox.get(savedStepsCount, defaultValue: 0)!;

    if (event.steps < savedStepsCount) {
      savedStepsCount = 0;
      stepBox.put(savedStepCountKey, savedStepsCount);
    }

    if (lastSavedDay < todayDayNo) {
        lastSavedDay = todayDayNo;
        savedStepsCount = event.steps;
        _totalStepCount = savedStepsCount;

      stepBox
        ..put(lastSavedDayKey, lastSavedDay)
        ..put(savedStepCountKey, savedStepsCount);

    }

    _stepCountToday = event.steps - savedStepsCount;

    if (kDebugMode) {
      print('Last Day $lastSavedDay');
      print('Saved Steps $savedStepsCount');
    }

    NotificationService.displayNotification(_stepCountToday.toString(), _status);
    getCalorieTerbakar(_stepCountToday);
    getDistance(_stepCountToday);
    notifyListeners();
  }

  void startDailyStepReset() {
    _dailyResetTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
      Duration timeUntilReset = tomorrow.difference(now);

      if (timeUntilReset.inSeconds > 0) {
        timeUntilReset -= const Duration(seconds: 1);
      } else if (timeUntilReset.inSeconds == 0) {
        _totalStepCount += _stepCountToday;
        _stepCountToday = 0;
        timeUntilReset = tomorrow.difference(DateTime.now());
        _dailyResetTimer.cancel();
      }
    });
    notifyListeners();
  }

  String getCalorieTerbakar(int steps) {
    num cal = steps * 0.04;
    cal.round();
    _calorie = "${cal.round()}";
    return _calorie;
  }

  double getCalorie(int steps){
    final cal = steps * 0.04;
    return cal;
  }

  String getDistance(int steps) {
    num distance = ((steps * 0.762) / 1000);
    distance = num.parse(distance.toStringAsFixed(2));
    _distance = "$distance km";
    return _distance;
  }


  Future<void> updateStep() async{
    var lastStep = await sessionManager.readStep(storageKey) ;
    var nik = await sessionManager.getNikUser("nik");
    var cal = getCalorieTerbakar(lastStep ?? 0);
    print("Langkah Terakhir $lastStep oleh $nik dengan $cal");
    _networkRepo.sendRecordLangkah(nik.toString(), lastStep.toString(), cal);

    notifyListeners();
  }


  String get pedestrianStatus => _status;

  String get calorieNow => _calorie;

  String get pedestrianStepCount => _stepCountToday.toString();

  String get distance => _distance;

  String get totalStepCount => _totalStepCount.toString();




}

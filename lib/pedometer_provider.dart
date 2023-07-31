import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

import 'helper/session_manager.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

class PedometerProvider with ChangeNotifier {
  int _stepCountToday = 0;
  int _totalStepCount = 0;
  String _calorie = "0";
  String _distance = "0";

  final Stream<StepCount> _stepCountStream = Pedometer.stepCountStream;
  final sessionManager = SessionManager();

  String _status = 'Standing';

  late Timer _dailyResetTimer;
  late Box<int> stepBox;
  final Stream<PedestrianStatus> _pedestrianStatusStream =
      Pedometer.pedestrianStatusStream;

  initialize() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    stepBox = await Hive.openBox('steps');
    checkPermission();
    notifyListeners();
  }

  Future<void> checkPermission() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> status;

    status = await [Permission.activityRecognition, Permission.notification]
        .request();

    status.forEach((permission, status) {
      if (status.isGranted) {
        startListening();
        startDailyStepReset();
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

    if (event.steps < savedStepsCount) {
      savedStepsCount = 0;
      stepBox.put(savedStepCountKey, savedStepsCount);
    }

    if (lastSavedDay < todayDayNo) {
      lastSavedDay = todayDayNo;
      savedStepsCount = event.steps;

      if (kDebugMode) {
        print('Last Day $lastSavedDay');
        print('Saved Steps $savedStepsCount');
      }

      stepBox
        ..put(lastSavedDayKey, lastSavedDay)
        ..put(savedStepCountKey, savedStepsCount);
    }
    _stepCountToday = event.steps - savedStepsCount;
    _totalStepCount = _stepCountToday;
    stepBox.put('today steps', _stepCountToday);

    getCalorieTerbakar(_stepCountToday);
    getDistance(_stepCountToday);
    showLocalNotification("MyDarling", _stepCountToday);

    // sendResponse(_stepCountToday);

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
      }
    });
    notifyListeners();
  }

  void showLocalNotification(String title, int body) {
    const androidNotificationDetail = AndroidNotificationDetails(
        '0', // channel Id
        'general',
        ongoing: true,
        autoCancel: false
        // channel Name
        );
    const notificationDetails =
        NotificationDetails(android: androidNotificationDetail);
    flutterLocalNotificationsPlugin.show(
        0, "MyDarling", _stepCountToday.toString(), notificationDetails);
    notifyListeners();
  }

  //logout
  void closeBox() {
    stepBox.clear();
    _stepCountToday = 0;
    notifyListeners();
  }

  String getCalorieTerbakar(int steps) {
    num cal = steps * 0.04;
    cal = num.parse(cal.toStringAsFixed(2));
    _calorie = "$cal";
    return _calorie;
  }

  String getDistance(int steps) {
    num distance = ((steps * 0.762) / 1000);
    distance = num.parse(distance.toStringAsFixed(2));
    _distance = "$distance km";
    return _distance;
  }

  String get pedestrianStatus => _status;

  String get calorieNow => _calorie;

  String get pedestrianStepCount => _stepCountToday.toString();

  String get distance => _distance;

  String get totalStepCount => _totalStepCount.toString();
}

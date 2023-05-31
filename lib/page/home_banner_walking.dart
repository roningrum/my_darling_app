import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeBannerWalking extends StatefulWidget {
  const HomeBannerWalking({Key? key}) : super(key: key);

  @override
  State<HomeBannerWalking> createState() => _HomeBannerWalkingState();
}

class _HomeBannerWalkingState extends State<HomeBannerWalking> {
  int todaySteps = 0;
  String _status = '?';

  String calorie = "0";
  String distanceKm ="0";
  late Box<int> stepsBox;
  late StreamSubscription<StepCount> _subscription;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  final networkRepo = NetworkRepo();
  final sessionManager = SessionManager();

  Future<void> initialize() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    stepsBox = await Hive.openBox('steps');
    checkPermission();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  Future<void> checkPermission() async {
    await Permission.activityRecognition.request();
    if (await Permission.activityRecognition.isDenied) {
      await Permission.activityRecognition.request().then((value) {
        if (value != PermissionStatus.denied) {
          startListening();
        } else {
          checkPermission();
        }
      });
    } else {
      startListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 16,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(
          left: 16.0, top: 20.0, bottom: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [primaryRed, primaryBlueBlack]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/walking.svg',
                      width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Text('Langkah Hari Ini',
                      style: regular.copyWith(fontSize: 12.0, color: white))
                ],
              ),
              const SizedBox(height: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('$todaySteps',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontFamily: 'Roboto Slab',
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/waktu.svg',
                      width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Text('00:01:05',
                      style: regular.copyWith(fontSize: 14.0, color: white))
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/kalori.svg',
                      width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Text(getCalorieTerbakar(todaySteps),
                      style: regular.copyWith(fontSize: 12.0, color: white))
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/jalan.svg',
                      width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(getDistance(todaySteps),
                          style:
                              regular.copyWith(fontSize: 14.0, color: white)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ForegroundService().stop();
    Hive.box('steps').compact();
    Hive.close();
    _subscription.cancel();
  }

  void startListening() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _subscription = Pedometer.stepCountStream
        .listen(getTodayStep, onError: _onError, onDone: _onDone);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    if (kDebugMode) {
      print(event);
    }
    setState((){
      _status = event.status;

      if (_status == "stopped") {
        sendResponse(todaySteps);
      }
    });
  }

  void onPedestrianStatusError(error) {
    if (kDebugMode) {
      print('onPedestrianStatusError: $error');
    }
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    if (kDebugMode) {
      print(_status);
    }
  }

  void _onDone() {
    if (kDebugMode) {
      print("Finished Tracking");
    }
  }

  void _onError(error) => print("Flutter Pedometer Error");

  Future<void> getTodayStep(StepCount value) async {
    int savedStepCountKey = 999999;
    int savedStepsCount = stepsBox.get(savedStepCountKey, defaultValue: 0)!;
    int todayDayNo = Jiffy.now().dayOfYear;

    if (kDebugMode) {
      print('Last Day $todayDayNo');
    }

    if (value.steps < savedStepsCount) {
      savedStepsCount = 0;
      stepsBox.put(savedStepCountKey, savedStepsCount);
    }

    int lastSavedDayKey = 888888;
    int lastSavedDay = stepsBox.get(lastSavedDayKey, defaultValue: 0)!;

    if (lastSavedDay < todayDayNo) {
      lastSavedDay = todayDayNo;
      savedStepsCount = value.steps;

      stepsBox
        ..put(lastSavedDayKey, lastSavedDay)
        ..put(savedStepCountKey, savedStepsCount);
    }
    setState(() {
      todaySteps = value.steps - savedStepsCount;

      if (kDebugMode) {
        print(todaySteps);
        print('last step $lastSavedDay');
        print('stepCount $savedStepsCount');
      }
    });
    stepsBox.put('today steps', todaySteps);

  }


  //dapat kalori terbakar
  String getCalorieTerbakar (int steps){
    num cal = steps *0.04;
    cal = num.parse(cal.toStringAsFixed(2));
    calorie = "$cal Cal";
    return calorie;
  }

  //dapat kalkulasi jarak langkah
  String getDistance(int steps){
    num distance = ((steps * 0.762)/1000);
    distance = num.parse(distance.toStringAsFixed(2));
    distanceKm = "$distance km";
    return distanceKm;
  }

void sendResponse(int steps) async{
  var nik = await sessionManager.getUserId('nik');
  networkRepo.sendRecordLangkah(nik!, todaySteps.toString());

}
}

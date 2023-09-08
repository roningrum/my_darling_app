import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/main.dart';
import 'package:my_darling_app/model/step_record_data.dart';
import 'package:my_darling_app/pedometer_provider.dart';
import 'package:my_darling_app/repository/local/local_database_repo.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:provider/provider.dart';

class HomeBannerWalking extends StatefulWidget {
  const HomeBannerWalking({Key? key}) : super(key: key);

  @override
  State<HomeBannerWalking> createState() => _HomeBannerWalkingState();
}

class _HomeBannerWalkingState extends State<HomeBannerWalking> with WidgetsBindingObserver{
  String todaySteps = "0";
  String calorie = "0";
  String distanceKm = "0";
  String nik ="";

  late PedometerProvider pedometerProvider;

  final networkRepo = NetworkRepo();
  final sessionManager = SessionManager();
  final localDatabase = LocalDatabaseRepo();
  String status = '';

  Future<String> getNIK() async{
    nik = (await sessionManager.getUserId('nik'))!;
    return nik;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    pedometerProvider = Provider.of<PedometerProvider>(context, listen: false);
    pedometerProvider.initialize();
    getNIK();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
        pedometerProvider.startListening();
        // setupNotification();
        break;
      case AppLifecycleState.paused:
        pedometerProvider.stop();
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PedometerProvider>(
        builder: (context, pedometerProvider, child) {
          // final langkah = int.parse(pedometerProvider.pedestrianStepCount);
          // final kalori = double.parse(pedometerProvider.calorieNow);
          // final stepData = StepRecordData(steps: langkah, cal: kalori);
          // localDatabase.addLangkahBaru(stepData: stepData);
          return Container(
            width: MediaQuery
                .of(context)
                .size
                .width - 16,
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
                            style: regular.copyWith(
                                fontSize: 12.0, color: white))
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(pedometerProvider.pedestrianStepCount,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontFamily: 'Roboto Slab',
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text('Status : ${pedometerProvider.pedestrianStatus}',
                        style: regular.copyWith(fontSize: 12.0, color: white))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/kalori.svg',
                            width: 24.0, height: 24.0),
                        const SizedBox(width: 6.0),
                        Text('${pedometerProvider.calorieNow}cal',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'Roboto Slab',
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/jalan.svg',
                            width: 24.0, height: 24.0),
                        const SizedBox(width: 6.0),
                        Text(pedometerProvider.distance,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'Roboto Slab',
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


}
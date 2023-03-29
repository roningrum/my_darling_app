import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/network_provider/NetworkRepository.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeBannerWalking extends StatefulWidget {
  const HomeBannerWalking({Key? key}) : super(key: key);

  @override
  State<HomeBannerWalking> createState() => _HomeBannerWalkingState();
}

class _HomeBannerWalkingState extends State<HomeBannerWalking> {
  var _accel = 0.0;
  var _currentAcc = 0.0;
  var lastAccel = 0.0;
  var stepCount = 0;
  double x= 0.0, y=0.0, z=0.0;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  final _networkRepo = NetworkRepository();
  final sessionManager = SessionManager();



  @override
  void initState() {
    super.initState();
    start();
  }

  void start() {
    _streamSubscriptions.add(
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
          setState(() {
            x = event.x;
            y = event.y;
            z = event.z;
            hitungStep(x, y, z);
          });

        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width -16,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              primaryRed,
              primaryBlueBlack
            ]
        ),
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/walking.svg',width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Text('Langkah Hari Ini', style: regular.copyWith(fontSize: 12.0, color: white))
                ],
              ),
              const SizedBox(height: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(stepCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 40.0, fontFamily: 'Roboto Slab', fontWeight: FontWeight.w600),),
                  Column(
                    children: [
                      Center(child: Text(getPrecentageWalk().toString(), style: regular.copyWith(fontSize: 12.0, color: white), textAlign: TextAlign.center)),
                      LinearPercentIndicator(
                          backgroundColor: Colors.white,
                          animation: true,
                          animationDuration: 1000,
                          width: 160,
                          lineHeight: 12.0,
                          percent:getPrecentageWalk()/100,
                          progressColor: const Color(0xff0CB061),
                          barRadius: const Radius.circular(8.0)
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  )
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
                  SvgPicture.asset('assets/icons/waktu.svg',width: 24.0, height: 24.0),
                  const SizedBox(width:6.0),
                  Text('00:01:05', style: regular.copyWith(fontSize: 14.0, color: white))
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/kalori.svg',width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Text('245 Kal', style: regular.copyWith(fontSize: 12.0, color: white))
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/jalan.svg',width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Target', style: regular.copyWith(fontSize: 10.0, color: white)),
                      const SizedBox(height: 4.0),
                      Text('10000', style: regular.copyWith(fontSize: 14.0, color: white)),
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



  void hitungStep(double x, double y, double z) {
    _accel = 10;
    // _currentAcc = 9.8;
    lastAccel = 9.8;
    lastAccel = _currentAcc;

    _currentAcc = sqrt((x*x)+(y*y)+(z*z));
    var delta = _currentAcc - lastAccel;
    _accel = delta.abs();
    if(_accel > 1){
      stepCount++;
    }
    if(stepCount>=1){
      Timer.periodic(const Duration(minutes: 2), (timer) {
        sendRecordWalk(stepCount);
      });
    }
    else{
      print('Jalan Lagi');
    }

    // print(stepCount);
  }

  double getPrecentageWalk(){
    var stepNow = stepCount;
    var percent = ((stepNow/1000)*100);
    return double.parse(percent.toStringAsFixed(2));
  }

  void sendRecordWalk(int step) async{
    var nik = await sessionManager.getNikUser('nik');
    var token = await sessionManager.readToken('token');
    var langkah = step;
    // var uploadTime = getDateToday();
    // print(nik.toString());
    // print(nik);
    if(nik != null){
      var response = await _networkRepo.sendWalkRecord(nik.toString(), langkah.toString(), token!);
      setState(() {
        if(response.status == "sukses"){
          if(stepCount >=1){
            print('${response.data}');
            stepCount = 0;
          }
          else{
            print('stop');
          }

          // stepCount = 0;
        }
        else{
          print('${response.pesan}');
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {

      subscription.cancel();
    }
  }
}



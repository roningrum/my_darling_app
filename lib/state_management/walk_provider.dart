import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:sensors_plus/sensors_plus.dart';

class WalkProvider extends ChangeNotifier{
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  double x=0.0, y=0.0, z=0.0;
  int stepCount = 0;


  WalkProvider(){
    // start();
    hitungStep();
  }

  void start(){
    _streamSubscriptions.add(
      userAccelerometerEvents.listen((UserAccelerometerEvent event) {
        x = event.x;
        y = event.y;
        z= event.z;
        hitungStep();
      })
    );
    notifyListeners();
  }

  void hitungStep(){
    var _accel = 10.0;
    var _currentAcc = 0.0;
    var _lastAccel = _currentAcc;

    _currentAcc = sqrt((x*x)+(y*y)+(z*z));
    var delta = _currentAcc - _lastAccel;
    _accel = delta.abs();
    notifyListeners();
  }
}
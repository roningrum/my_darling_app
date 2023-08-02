import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class NetworkHelper{
  NetworkHelper._();
  static final _instance  = NetworkHelper._();
  static NetworkHelper get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;


  void initialize() async{
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      if (kDebugMode) {
        print(result);
        _checkStatus(result);
      }
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try{
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on PlatformException catch (e){
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }
  void disposeStream() => _controller.close();
}
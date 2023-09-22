import 'package:flutter/foundation.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/local/record_data.dart';
import 'package:my_darling_app/storage_provider.dart';
import 'package:pedometer/pedometer.dart';

class PedometerService {
  final StorageProvider<RecordData> _storage;

  PedometerService({required StorageProvider<RecordData> storage})
      : _storage = storage;

  final Stream<StepCount> _stepCountStream = Pedometer.stepCountStream;
  final Stream<PedestrianStatus> _pedestrianStatusStream =
      Pedometer.pedestrianStatusStream;
  final String storageyKey = "pedometer";



  var _data = RecordData();
  bool _isInitialized = false;

  // int get StepCurrent => _isInitialized ? _data.stepsDaily : Pedometer.

  //initialize
  Future<bool> initialize() async {
    final result = await _storage.read(storageyKey);
    if (result != null) {
      _data = result;
    }
    return _isInitialized = true;
  }

  //start Pedometer here!
  Future<void> startPedometer() async {
    _pedestrianStatusStream
        .listen(onPedestrianChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  Future <int> fetchData() async{
    if(!_isInitialized){
      return -1;
    }
    await _storage.write(storageyKey, _data);
    return _data.stepsDaily;
  }

  void onStepCount(StepCount event){
    int newSteps = 0;
    int currentStep = event.steps;

    if(currentStep < _data.lastReading){
      newSteps = currentStep;
    }
    else if(_data.lastReading > 0){
      newSteps = currentStep - _data.lastReading;
    }

    if(_data.lastPedometerTimeStamp.isToday){
      _data.stepsDaily += newSteps;
    }
    else{
      _data.stepsDaily = 0;
    }

    _data.lastReading = currentStep;
    _data.lastPedometerTimeStamp = DateTime.now();
  }

  void onStepCountError(){
    if (kDebugMode) {
      print('onStepCountError: Cant read');
    }
  }
  void onPedestrianChanged(PedestrianStatus status){
    if (kDebugMode) {
      print('onStepCountError: Cant read');
    }

  }
  void onPedestrianStatusError(){}
}

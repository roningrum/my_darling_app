import 'package:my_darling_app/local/record_data.dart';
import 'package:my_darling_app/storage_provider.dart';

class PedometerService{
  final StorageProvider<RecordData> _storage;
  PedometerService({ required StorageProvider<RecordData> storage}) : _storage = storage;

  var _data = RecordData();
  bool _isInitialized = false;

  int get StepCurrent => _isInitialized ? _data.stepsDaily :
}
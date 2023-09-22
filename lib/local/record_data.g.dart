// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordData _$RecordDataFromJson(Map<String, dynamic> json) => RecordData()
  ..stepsDaily = json['stepsDaily'] as int
  ..lastReading = json['lastReading'] as int
  ..calorie = (json['calorie'] as num).toDouble()
  ..lastPedometerTimeStamp =
      DateTime.parse(json['lastPedometerTimeStamp'] as String);

Map<String, dynamic> _$RecordDataToJson(RecordData instance) =>
    <String, dynamic>{
      'stepsDaily': instance.stepsDaily,
      'lastReading': instance.lastReading,
      'calorie': instance.calorie,
      'lastPedometerTimeStamp':
          instance.lastPedometerTimeStamp.toIso8601String(),
    };

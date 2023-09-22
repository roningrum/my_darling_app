import 'package:json_annotation/json_annotation.dart';

part 'record_data.g.dart';

@JsonSerializable()
class RecordData {
  RecordData();

  int stepsDaily = 0;

  int lastReading = 0;

  double calorie = 0.0;

  DateTime lastPedometerTimeStamp = DateTime.now();

  factory RecordData.fromJson(Map<String, dynamic> json) =>
      _$RecordDataFromJson(json);

  Map<String, dynamic> toJson() => _$RecordDataToJson(this);

  bool compareTo(RecordData other) {
    return stepsDaily == other.stepsDaily &&
        lastReading == other.lastReading &&
        other.calorie == calorie &&
        lastPedometerTimeStamp == other.lastPedometerTimeStamp;
  }
}

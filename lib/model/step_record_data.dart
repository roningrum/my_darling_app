import 'package:hive/hive.dart';

part 'step_record_data.g.dart';

@HiveType(typeId: 0)
class StepRecordData extends HiveObject{
  // static const boxName = 'stepData';

  @HiveField(1)
  final int steps;

  @HiveField(2)
  final double cal;

  @HiveField(3)
  DateTime timeStamp = DateTime.now();

  StepRecordData({required this.steps, required this.cal});

}
import 'package:hive/hive.dart';

part 'step_record_data.g.dart';

@HiveType(typeId: 0)
class StepRecordData extends HiveObject{
  static const boxName = 'stepData';

  @HiveField(1)
  int steps = 0;

  @HiveField(2)
  double cal = 0.0;

  @HiveField(3)
  DateTime timeStamp = DateTime.now();

  bool compareTo(StepRecordData otherData){
    return steps == otherData.steps && cal == otherData.cal && timeStamp == otherData.timeStamp;
  }
}
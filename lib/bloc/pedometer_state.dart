import 'package:my_darling_app/model/step_record_data.dart';

abstract class PedometerState{
  final int stepDaily;
  final int stepRecord;
  final int calorieDaily;
  final List<StepRecordData> stepHistory;
  const PedometerState(this.stepDaily, this.stepRecord, this.calorieDaily, this.stepHistory);
}

class PedometerInitial extends PedometerState{
 const PedometerInitial(super.stepDaily, super.stepRecord, super.calorieDaily, super.stepHistory);
}

class PedometerStartFailure extends PedometerState{
  final String error;
  const PedometerStartFailure(this.error, super.stepDaily, super.stepRecord, super.calorieDaily, super.stepHistory);
}

class PedometerStopSuccess extends PedometerState{
  const PedometerStopSuccess(super.stepDaily, super.stepRecord, super.calorieDaily, super.stepHistory);
}

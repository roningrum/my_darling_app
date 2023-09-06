import 'package:hive/hive.dart';
import 'package:my_darling_app/model/step_record_data.dart';

class LocalDatabaseRepo{
  static const boxName = "recordLangkahBox";

  static Box<StepRecordData> box = Hive.box(boxName);

  //add data baru
  Future<void> addLangkahBaru({required StepRecordData stepData}) async{
    await box.add(stepData);
  }

  //lihat semua data kerekam
  Future<void> getSemuaLangkah({required String id}) async{
    box.get(id);
  }
}
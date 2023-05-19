import 'package:intl/intl.dart';

DateTime getDateToday(){
  var dateNow = DateTime.now();
  return dateNow;
}

String getTodayDate(){
  var date = DateTime.now();
  var dateFormat = DateFormat('dd-MM-yyyy');
  var todayDay = dateFormat.format(date);
  return todayDay;
}
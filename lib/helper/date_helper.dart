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

String dateFormat(String? tgl){
  if(tgl != null){
    var date = DateTime.parse(tgl);
    var m = DateFormat('MM').format(date);
    var d = DateFormat('dd').format(date).toString();
    var Y = DateFormat('yyyy').format(date).toString();
    var month= "";
    switch(m){
      case '01':
        month = "Januari";
        break;
      case '02':
        month ="Februari";
        break;
      case '03':
        month ="Maret";
        break;
      case '04':
        month ="April";
        break;
      case '05':
        month ="Mei";
        break;
      case '06':
        month ="Juni";
        break;
      case '07':
        month ="Juli";
        break;
      case '08':
        month ="Agustus";
        break;
      case '09':
        month ="September";
        break;
      case '10':
        month ="Oktober";
        break;
      case '11':
        month ="November";
        break;
      case '12':
        month ="Desember";
        break;
    }
    var todayDay = "$d $month $Y";
    return todayDay;
  }
  else{
    return '-';
  }
}

String formatTanggal (String date){
  var tgl = DateTime.parse(date);
  var formatTgl = DateFormat('yyyy-MM-dd');
  var tglBaru = formatTgl.format(tgl);
  return tglBaru;
}

String formatTglSurat(String? date){
  if(date != null){
    var tgl = DateTime.parse(date);
    var formatTgl = DateFormat('dd-MM-yyyy');
    var tglBaru = formatTgl.format(tgl);
    return tglBaru;
  }
  else{
    return "1970-01-01";
  }

}

String dateParameter(){
  var date = getDateToday();
  var dateFormat = DateFormat('yyyy-MM-dd');
  var todayDay = dateFormat.format(date);
  return todayDay;
}
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeBannerChart extends StatefulWidget {
  final String nik;

  const HomeBannerChart({super.key, required this.nik});

  @override
  State<HomeBannerChart> createState() => _HomeBannerChartState();
}

class _HomeBannerChartState extends State<HomeBannerChart> {
  final _networkRepo = NetworkRepo();
  List<_RecordData> recordData = [];
  List<_RecordCalorie> recordCal = [];
  List<int> listOfDates =[];
  String month = "";

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlueBlack,
        title: Text(
          'Aktivitas Harian',
          style: title.copyWith(color: white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Row(
                  children: [
                    Text(
                        "Pilih Bulan :",
                        style: title.copyWith(fontSize: 14, color: primaryBlueBlack)),
                    const SizedBox(width: 8.0),
                    SizedBox(
                      width: 150,
                      height: 64,
                      child: DropdownDatePicker(
                          textStyle: title.copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.w400),
                          inputDecoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          isFormValidator: true,
                          showDay: false,
                          showYear: false,
                          startYear: 2000,
                          endYear: DateTime.now().year,
                          width: 8,
                          selectedMonth:DateTime.now().month,
                          // optional
                          onChangedMonth: (value) {
                            setState(() {
                              value != null
                                  ? month = value
                                  : month = DateFormat("M").format(DateTime.now());
                            });
                          }
                        // print(month);
                      ),
                    ),
                  ]
              ),
              const SizedBox(height: 16.0),
              Text(
                  "Record Aktivitas ${month!=""?getMonths(month): getMonths(DateFormat("M").format(DateTime.now()))}",
                  style: title.copyWith(fontSize: 16, color: primaryBlueBlack)),
              const SizedBox(height: 16.0),
              getDataLangkah(month, DateFormat('yyyy').format(DateTime.now())),
              const SizedBox(height: 16.0),
              Text(
                  "Record Kalori ${month!=""?getMonths(month): getMonths(DateFormat("M").format(DateTime.now()))}",
                  style: title.copyWith(fontSize: 16, color: primaryBlueBlack)),
              const SizedBox(height: 16.0),
              getDataKalori(month, DateFormat('yyyy').format(DateTime.now()))
            ],
          ),
        ),
      ),
    );
  }

  Widget getDataLangkah(String month, String year) {
    if (kDebugMode) {
      print("Bulan $month");
    }
    if(month!=""){
      listOfDates.clear();
      var totalDays = daysInMonth(month);
      listOfDates = List<int>.generate(totalDays, (index) => index + 1);
      return FutureBuilder(
        future: _networkRepo.getTotalLangkah(widget.nik, month, year),
        initialData: const [],
        builder: (context, snapshot){
          if (snapshot.hasData) {
            var data = snapshot.data;
            recordData.clear();
            if(data != null){
              // recordData.clear();
              for (var i= 0;i<listOfDates.length; i++) {
                if(data.length == listOfDates.length){
                  recordData.add(_RecordData(listOfDates[i], data[i]));
                  print("record data ${recordData[i].langkah}");
                  print("record data $listOfDates");
                }
              }
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0.0,
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Langkah'),
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.rotate90,
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  enableAxisAnimation: true,
                  series: <ChartSeries<_RecordData, int>>[
                    ColumnSeries<_RecordData, int>(
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            showZeroValue: false,
                            alignment: ChartAlignment.far,
                            labelIntersectAction: LabelIntersectAction.shift,
                            color: secondaryBlueBlack),
                        color: Colors.deepOrangeAccent,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        borderWidth: 100,
                        dataSource: recordData,
                        xValueMapper: (_RecordData data, _) => data.tgl,
                        yValueMapper: (_RecordData data, _) => data.langkah)
                  ],
                ),
              ),
            );
          }
          else{
            return Container();
          }
        },
      );
    }
    else{
      return FutureBuilder(
        future: _networkRepo.getTotalLangkah(widget.nik, DateFormat("MM").format(DateTime.now()), year),
        initialData: const [],
        builder: (context, snapshot){
          if (snapshot.hasData) {
            var data = snapshot.data;
            listOfDates.clear();
            recordData.clear();
              var now = DateTime.now().month;
              var totalDays = daysInMonth(now.toString());
              listOfDates = List<int>.generate(totalDays, (index) => index + 1);
              if(data != null){
                // recordData.clear();
                for (var i= 0;i<listOfDates.length; i++) {
                  if(data.length == listOfDates.length){
                    recordData.add(_RecordData(listOfDates[i], data[i]));
                    print("record data ${recordData[i].langkah}");
                    print("record data $listOfDates");
                  }
                }
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1000,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0.0,
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Langkah'),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryXAxis: CategoryAxis(
                      labelIntersectAction: AxisLabelIntersectAction.rotate90,
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    enableAxisAnimation: true,
                    series: <ChartSeries<_RecordData, int>>[
                      ColumnSeries<_RecordData, int>(
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              showZeroValue: false,
                              alignment: ChartAlignment.far,
                              labelIntersectAction: LabelIntersectAction.shift,
                              color: secondaryBlueBlack),
                          color: Colors.deepOrangeAccent,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          borderWidth: 100,
                          dataSource: recordData,
                          xValueMapper: (_RecordData data, _) => data.tgl,
                          yValueMapper: (_RecordData data, _) => data.langkah)
                    ],
                  ),
                ),
              );
            }
          else{
            return Container();
          }
          }
      );
    }



  }

  Widget getDataKalori(String month, String year) {
    if (kDebugMode) {
      print("Bulan $month");
    }
    if(month!=""){
      listOfDates.clear();
      var totalDays = daysInMonth(month);
      listOfDates = List<int>.generate(totalDays, (index) => index + 1);
      return FutureBuilder(
        future: _networkRepo.getTotalKalori(widget.nik, month, year),
        initialData: const [],
        builder: (context, snapshot){
          if (snapshot.hasData) {
            var data = snapshot.data;
            recordCal.clear();
            if(data != null){
              // recordData.clear();
              for (var i= 0;i<listOfDates.length; i++) {
                if(data.length == listOfDates.length){
                  recordCal.add(_RecordCalorie(listOfDates[i], data[i]));
                  print("record data ${recordCal[i].calorie}");
                  print("record data $listOfDates");
                }
              }
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1000,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0.0,
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Langkah'),
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  primaryXAxis: CategoryAxis(
                    labelIntersectAction: AxisLabelIntersectAction.rotate90,
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  enableAxisAnimation: true,
                  series: <ChartSeries<_RecordCalorie, int>>[
                    ColumnSeries<_RecordCalorie, int>(
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            showZeroValue: false,
                            alignment: ChartAlignment.far,
                            labelIntersectAction: LabelIntersectAction.shift,
                            color: secondaryBlueBlack),
                        color: Colors.deepOrangeAccent,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        borderWidth: 100,
                        dataSource: recordCal,
                        xValueMapper: (_RecordCalorie data, _) => data.tgl,
                        yValueMapper: (_RecordCalorie data, _) => data.calorie)
                  ],
                ),
              ),
            );
          }
          else{
            return Container();
          }
        },
      );
    }
    else{
      return FutureBuilder(
          future: _networkRepo.getTotalKalori(widget.nik, DateFormat("MM").format(DateTime.now()), year),
          initialData: const [],
          builder: (context, snapshot){
            if (snapshot.hasData) {
              var data = snapshot.data;
              recordCal.clear();
              if(data != null){
                // recordData.clear();
                for (var i= 0;i<listOfDates.length; i++) {
                  if(data.length == listOfDates.length){
                    recordCal.add(_RecordCalorie(listOfDates[i], data[i]));
                    print("record data ${recordCal[i].calorie}");
                    print("record data $listOfDates");
                  }
                }
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1000,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0.0,
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(text: 'Langkah'),
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryXAxis: CategoryAxis(
                      labelIntersectAction: AxisLabelIntersectAction.rotate90,
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    enableAxisAnimation: true,
                    series: <ChartSeries<_RecordCalorie, int>>[
                      ColumnSeries<_RecordCalorie, int>(
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              showZeroValue: false,
                              alignment: ChartAlignment.far,
                              labelIntersectAction: LabelIntersectAction.shift,
                              color: secondaryBlueBlack),
                          color: Colors.deepOrangeAccent,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          borderWidth: 100,
                          dataSource: recordCal,
                          xValueMapper: (_RecordCalorie data, _) => data.tgl,
                          yValueMapper: (_RecordCalorie data, _) => data.calorie)
                    ],
                  ),
                ),
              );
            }
            else{
              return Container();
            }
          }
      );
    }

  }

  int daysInMonth(String bulan) {
    int year = DateTime.now().year;
    int month = int.parse(bulan);

    var lastDayMonth =
        (month < 12) ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
    return lastDayMonth.day;
  }



  DateTime getFormatDateTime(String tgl) {
    var date = DateTime.parse(tgl);
    return date;
  }

  String getMonths(String bulan){
    switch(bulan){
      case '1':
        return "Januari";
      case '2':
        return "Februari";
      case '3':
        return "Maret";
      case '4':
        return "April";
      case '5':
        return "Mei";
      case '6':
        return "Juni";
      case '7':
        return "Juli";
      case '8':
        return "Agustus";
      case '9':
        return "September";
      case '10':
        return "Oktober";
      case '11':
        return "November";
      case '12':
        return "Desember";
    }

    return bulan;
  }
}

class _RecordData {
  int? tgl;
  int? langkah;

  _RecordData(this.tgl, this.langkah);
}

class _RecordCalorie {
  final int tgl;
  final int calorie;

  _RecordCalorie(this.tgl, this.calorie);
}

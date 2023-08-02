import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  String month = "";

  @override
  void initState() {
    // TODO: implement initState
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
              Text(
                  "Record Aktivitas ${DateFormat(DateFormat.YEAR_MONTH).format(DateTime.now())}",
                  style: title.copyWith(fontSize: 16, color: primaryBlueBlack)),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 350,
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
                    selectedMonth: DateTime.now().month,
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
              const SizedBox(height: 16.0),
              getDataLangkah(month, DateFormat('yyyy').format(DateTime.now())),
              const SizedBox(height: 16.0),
              Text(
                  "Record Kalori terbakar ${DateFormat(DateFormat.YEAR_MONTH).format(DateTime.now())}",
                  style: title.copyWith(fontSize: 16, color: primaryBlueBlack)),
              const SizedBox(height: 16.0),
              FutureBuilder(
                future: _networkRepo.getTotalKalori(widget.nik, DateFormat('MM').format(DateTime.now()), DateFormat('yyyy').format(DateTime.now())),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  var now = DateTime.now().month;
                  var totalDays = daysInMonth(now.toString());
                  var listofDates = List<int>.generate(totalDays, (index) => index+1);
                  if(data != null){
                    for(int i = 0; i<listofDates.length; i++){

                      recordCal.add(_RecordCalorie(listofDates[i], data[i]));
                    }
                  }
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 1000,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0.0,
                          primaryYAxis: NumericAxis(
                            title: AxisTitle(text:'Langkah'),
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
                                showZeroValue: false, alignment: ChartAlignment.far,
                                labelIntersectAction: LabelIntersectAction.shift,
                                color: secondaryBlueBlack
                              ),
                                color: Colors.deepOrangeAccent,
                                borderRadius: const BorderRadius.only(topLeft:Radius.circular(8.0), topRight: Radius.circular(8.0)),
                                borderWidth: 100,
                                dataSource: recordCal,
                                animationDuration: 2000,
                                xValueMapper: (_RecordCalorie data, _) => data.tgl,
                                yValueMapper: (_RecordCalorie data, _) => data.calorie
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
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
    return FutureBuilder(
      future: _networkRepo.getTotalLangkah(widget.nik, month, year),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          if (month != "") {
            var totalDays = daysInMonth(month);
            var listofDates = List<int>.generate(totalDays, (index) => index + 1);
            //
            print(listofDates);
            if(data != null){
              for (int i = 0; i < listofDates.length; i++) {
                recordData.add(_RecordData(listofDates[i], data[i]));
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
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
    // // var now = DateTime.now();
    // var totalDays = daysInMonth(month);
    // var listofDates = List<int>.generate(totalDays, (index) => index + 1);
    // //
    // if (kDebugMode) {
    //   print(listofDates);
    // }

    // return Container();

  }

  int daysInMonth(String bulan) {
    int year = DateTime.now().year;
    int month = int.parse(bulan);

    var now = DateTime.now();

    var lastDayMonth =
        (month < 12) ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
    return lastDayMonth.day;
  }

  DateTime getFormatDateTime(String tgl) {
    var date = DateTime.parse(tgl);
    return date;
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

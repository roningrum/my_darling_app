import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_darling_app/repository/model/record_langkah.dart';
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
  late ZoomPanBehavior _zoomPanBehavior;

  int day = 0;
  int month = 0;
  int year = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    print('User Nik : ${widget.nik}');
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
            children: [
              Text("Riwayat Langkah",
                  style: title.copyWith(fontSize: 16, color: primaryBlueBlack)),
              const SizedBox(height: 16.0),
              FutureBuilder(
                future: _networkRepo.getAllRecordDaily(widget.nik),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 2,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0.0,
                          primaryYAxis: NumericAxis(
                              isVisible: false,
                              majorGridLines: const MajorGridLines(width: 0)),
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.E(),
                            labelIntersectAction: AxisLabelIntersectAction.trim,
                            desiredIntervals: DateTime.daysPerWeek,
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                          ),
                          enableAxisAnimation: true,
                          series: <ChartSeries<RecordLangkah, DateTime>>[
                            ColumnSeries<RecordLangkah, DateTime>(
                                color: Colors.deepOrangeAccent,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true),
                                dataSource: data!,
                                borderRadius: BorderRadius.circular(10),
                                xValueMapper: (RecordLangkah recordData, _) =>
                                    getFormatDateTime(
                                        recordData.createdAt ?? ""),
                                yValueMapper: (RecordLangkah data, _) {
                                  if (kDebugMode) {
                                    print(data.langkah);
                                  }
                                  return data.langkah;
                                })
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  DateTime getFormatDateTime(String tgl) {
    var date = DateTime.parse(tgl);
    var year = date.year;
    var month = date.month;
    var day = date.day;
    return DateTime(year, month, day);
  }
}

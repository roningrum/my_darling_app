import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/repository/model/Walking_data_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';

class WalkingChartPage extends StatefulWidget {
  const WalkingChartPage({super.key});

  @override
  State<WalkingChartPage> createState() => _WalkingChartPageState();
}

class _WalkingChartPageState extends State<WalkingChartPage> {
  final _networkRepo = NetworkRepo();
  final _sessionManager = SessionManager();

  String? nik;

  Future<String?> getNIK() async {
    nik = await _sessionManager.getNikUser("nik");
    return nik;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNIK();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlueBlack,
        title: Text('Riwayat Jalan',
            style: title.copyWith(color: white, fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            walkingHistory(),
          ],
        ),
      ),
    );
  }

  Widget walkingHistory() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder(
          future: _networkRepo.getCatatanKesehatan(nik),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Container(
                width: 1000,
                height: 250,
                padding: const EdgeInsets.only(top: 8.0),
                child: BarChart(BarChartData(
                    alignment: BarChartAlignment.center,
                    borderData: FlBorderData(
                        border: const Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          left: BorderSide.none,
                          bottom: BorderSide(width: 1),
                        )),
                    gridData: FlGridData(show: false),
                    barTouchData: BarTouchData(enabled: true),
                    // barGroups: BarDa
                    // barGroups: [
                    //   BarChartGroupData(x: 1, barRods: [
                    //     BarChartRodData(toY: 10, fromY: 0, width: 15)
                    //   ]),
                    //   BarChartGroupData(x: 2, barRods: [
                    //     BarChartRodData(toY: 10, fromY: 0, width: 15)
                    //   ]),
                    //   BarChartGroupData(x: 3, barRods: [
                    //     BarChartRodData(toY: 11, fromY: 0, width: 15)
                    //   ]),
                    //   BarChartGroupData(x: 4, barRods: [
                    //     BarChartRodData(toY: 12, fromY: 0, width: 15)
                    //   ]),
                    //   BarChartGroupData(x: 5, barRods: [
                    //     BarChartRodData(toY: 15, fromY: 0, width: 15)
                    //   ]),
                    //   BarChartGroupData(x: 6, barRods: [
                    //     BarChartRodData(toY: 16, fromY: 0, width: 15)
                    //   ]),
                    //   BarChartGroupData(x: 7, barRods: [
                    //     BarChartRodData(toY: 17, fromY: 0, width: 15)
                    //   ]),
                    //   BarChartGroupData(x: 8, barRods: [
                    //     BarChartRodData(toY: 17, fromY: 0, width: 15)
                    //   ]),
                    //   BarChartGroupData(x: 9, barRods: [
                    //     BarChartRodData(toY: 17, fromY: 0, width: 15)
                    //   ]),
                    // ])),
              );
            }
            return Container(
              width: 1000,
              height: 250,
              padding: const EdgeInsets.only(top: 8.0),
              child: BarChart(BarChartData(
                  alignment: BarChartAlignment.center,
                  borderData: FlBorderData(
                      border: const Border(
                    top: BorderSide.none,
                    right: BorderSide.none,
                    left: BorderSide.none,
                    bottom: BorderSide(width: 1),
                  )),
                  gridData: FlGridData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 10, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 10, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(toY: 11, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(toY: 12, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 5, barRods: [
                      BarChartRodData(toY: 15, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 6, barRods: [
                      BarChartRodData(toY: 16, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 7, barRods: [
                      BarChartRodData(toY: 17, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 8, barRods: [
                      BarChartRodData(toY: 17, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 9, barRods: [
                      BarChartRodData(toY: 17, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 10, barRods: [
                      BarChartRodData(toY: 17, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 11, barRods: [
                      BarChartRodData(toY: 17, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 12, barRods: [
                      BarChartRodData(toY: 17, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 13, barRods: [
                      BarChartRodData(toY: 17, fromY: 0, width: 15)
                    ]),
                    BarChartGroupData(x: 14, barRods: [
                      BarChartRodData(toY: 17, fromY: 0, width: 15)
                    ]),
                  ])),
            );
          }),
    );
  }
}

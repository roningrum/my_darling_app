import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/repository/model/catatan_kesehatan_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/widget/cekkesehatan_list.dart';

import '../theme/theme.dart';

class CekKesehatan extends StatefulWidget {
  const CekKesehatan({Key? key}) : super(key: key);

  @override
  State<CekKesehatan> createState() => _CekKesehatanState();
}

class _CekKesehatanState extends State<CekKesehatan> {
  final networkRepo = NetworkRepo();
  final sessionManager = SessionManager();
  String? nik;

  Future<List<CatatanKesehatanResponse>> getCatatan() async {
    nik = await sessionManager.getNikUser('nik');
    // nik = "9202125312940001";
    final response = await networkRepo.getCatatanKesehatan(nik);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cek Kesehatan Ku ',
              style: title.copyWith(color: Colors.white, fontSize: 16)),
          backgroundColor: primaryBlueBlack,
        ),
        body: FutureBuilder<List<CatatanKesehatanResponse>>(
          future: getCatatan(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text("Tidak ada Riwayat yg terekam",
                      style: regular.copyWith(
                          fontSize: 14.0, color: secondaryBlueBlack)),
                );
              }
              else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CekKesehatanWidget(
                          catatanKesehatanResponse: snapshot.data![index]);
                    });
              }
            } else if (snapshot.hasError) {
              return Text("Tidak ada Riwayat yg terekam",
                  style: regular.copyWith(
                      fontSize: 14.0, color: secondaryBlueBlack));
            }
            else{
            return Center(child: CircularProgressIndicator(color: primaryRed));
            }
          },
        )
    );
  }

}

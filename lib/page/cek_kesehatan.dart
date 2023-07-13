import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/repository/model/catatan_kesehatan_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/widget/cekkesehatan_list.dart';
import 'package:my_darling_app/widget/edispo/akm_riwayat_profile.dart';

import '../theme/theme.dart';

class CekKesehatan extends StatefulWidget {
  final String nama;
  final String nik;

  const CekKesehatan({Key? key, required this.nama, required this.nik})
      : super(key: key);

  @override
  State<CekKesehatan> createState() => _CekKesehatanState();
}

class _CekKesehatanState extends State<CekKesehatan> {
  final networkRepo = NetworkRepo();
  final sessionManager = SessionManager();

  // String? nik;

  Future<List<CatatanKesehatanResponse>> getCatatan() async {
    // nik = await sessionManager.getNikUser("nik");
    // nik = "9202125312940001";
    final response = await networkRepo.getCatatanKesehatan(widget.nik);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cek Kesehatan Ku ',
              style: title.copyWith(color: Colors.white, fontSize: 16)),
          backgroundColor: primaryBlueBlack,
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 0,
                          child: Text(
                            'Tambah Manual',
                            style: regular.copyWith(fontSize: 16.0),
                          ))
                    ])
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Catatan Kesehatan ${widget.nama}",
                    style: title.copyWith(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  "Catatan Kesehatan di AKM",
                  style: title.copyWith(
                      fontSize: 14.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
                AkmRiwayatWidget(nik: widget.nik),
                const SizedBox(height: 12.0),
                Text(
                  "Rekam Medis di Yoh Sehat",
                  style: title.copyWith(
                      fontSize: 14.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
                FutureBuilder<List<CatatanKesehatanResponse>>(
                  future: getCatatan(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 16.0),
                              Center(
                                child: Text(
                                    "Saat ini belum ada catatan terekam",
                                    style: regular.copyWith(
                                        fontSize: 14.0,
                                        color: secondaryBlueBlack)),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CekKesehatanWidget(
                                catatanKesehatanResponse: snapshot.data![index],
                                nama: widget.nama,
                              );
                            });
                      }
                    } else if (snapshot.hasError) {
                      return Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const SizedBox(height: 16.0),
                            SvgPicture.asset("assets/icons/no_data.svg", width: 120, height: 120,),
                            const SizedBox(height: 8.0),
                            Text("Tidak ada Riwayat yg terekam",
                                style: regular.copyWith(
                                    fontSize: 14.0, color: secondaryBlueBlack)),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(color: primaryRed));
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

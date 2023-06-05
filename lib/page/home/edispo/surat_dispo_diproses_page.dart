import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/repository/model/surat_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo/surat_item.dart';

class SuratDispoDiproses extends StatefulWidget {
  final String keteranganProses;
  final String jenisSurat;

  SuratDispoDiproses(
      {Key? key, required this.keteranganProses, required this.jenisSurat})
      : super(key: key);

  @override
  State<SuratDispoDiproses> createState() => _SuratDispoDiprosesState();
}

class _SuratDispoDiprosesState extends State<SuratDispoDiproses> {
  TextEditingController dateinput = TextEditingController();

  final _networkRepo = NetworkRepo();
  final _sessionManager = SessionManager();

  String rule ="";
  String bidang="";
  String seksi ="";
  String userId = "";

  @override
  void initState() {
    // TODO: implement initState
    iniateState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Text(
              '${widget.jenisSurat} pada tanggal ${getTodayDate()}',
              style: title.copyWith(color: secondaryBlueBlack, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            widget.keteranganProses == "Sudah Diproses"
                ? suratDiproses()
                : Text("Belum Ada")
          ],
        ),
      ),
    );
  }

  Future<void> iniateState() async {
    var ruleLocale = await _sessionManager.getRule('rule');
    var bidangLocale = await _sessionManager.getBidang('bidang');
    var seksiLocale = await _sessionManager.getSeksi('seksi');
    var userIdLocale = await _sessionManager.getUserId('userId');

    setState(() {
      rule = ruleLocale!;
      bidang = bidangLocale!;
      seksi = seksiLocale!;
      userId = userIdLocale!;

      if (kDebugMode) {
        print('Rule : $rule');
      }
    });
  }

  Widget suratDiproses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [daftarSurat()],
    );
  }

  Widget daftarSurat() {
    if (kDebugMode) {
      print('Rule Sekarang : $rule');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        FutureBuilder<List<Surat>>(
            future: _networkRepo.getSuratDiproses(
                widget.jenisSurat, bidang, rule, seksi, userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: primaryRed));
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Gagal Memuat",
                        style: regular.copyWith(
                            fontSize: 14.0, color: secondaryBlueBlack)),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, index) {
                        return SuratItem(surat: snapshot.data![index]);
                      }));
                } else {
                  return Center(
                    child: Text("Tidak ada Data",
                        style: regular.copyWith(
                            fontSize: 14.0, color: secondaryBlueBlack)),
                  );
                }
              } else {
                return Center(
                  child: Text("Koneksi bermasalah, Coba beberapa saat",
                      style: regular.copyWith(
                          fontSize: 14.0, color: secondaryBlueBlack)),
                );
              }
            })
      ],
    );
  }

  String getTodayDate() {
    var date = DateTime.now();
    var dateFormat = DateFormat('dd-MM-yyyy');
    var todayDay = dateFormat.format(date);
    return todayDay;
  }
}

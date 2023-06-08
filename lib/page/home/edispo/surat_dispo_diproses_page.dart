import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_darling_app/repository/model/surat_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo/surat_item.dart';

class SuratDispoDiproses extends StatefulWidget {
  final String keteranganProses;
  final String jenisSurat;
  final String rule;
  final String bidang;
  final String userId;
  final String seksi;

  const SuratDispoDiproses(
      {Key? key,
      required this.keteranganProses,
      required this.jenisSurat,
      required this.rule,
      required this.bidang,
      required this.userId,
      required this.seksi})
      : super(key: key);

  @override
  State<SuratDispoDiproses> createState() => _SuratDispoDiprosesState();
}

class _SuratDispoDiprosesState extends State<SuratDispoDiproses> {
  TextEditingController dateinput = TextEditingController();

  final _networkRepo = NetworkRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kDebugMode) {
      print("nilai masuk, rule : ${widget.rule}");
    }
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

  Widget suratDiproses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        daftarSurat(widget.rule, widget.bidang, widget.seksi, widget.userId)
      ],
    );
  }

  Widget daftarSurat(String rule, String bidang, String seksi, String userId) {
    if (kDebugMode) {
      print('Data rule $rule, bidang $bidang, seksi $seksi, userId $userId');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        FutureBuilder<List<Surat>>(
            future: _networkRepo.getSuratDiproses(
                widget.jenisSurat, bidang, rule, seksi, userId),
            builder: (context, snapshot) {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data?.length,
                  itemBuilder: ((context, index) {
                    if(snapshot.data != null){
                      return SuratItem(surat: snapshot.data![index]);
                    }

                  }));
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

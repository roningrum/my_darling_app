import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';

class SuratSudahDiproses extends StatefulWidget {
  final String jenisSurat;
  final String rule;
  final String bidang;
  final String userId;
  final String seksi;

  const SuratSudahDiproses(
      {super.key,
      required this.jenisSurat,
      required this.rule,
      required this.bidang,
      required this.userId,
      required this.seksi});

  @override
  State<SuratSudahDiproses> createState() => _SuratSudahDiprosesState();
}

class _SuratSudahDiprosesState extends State<SuratSudahDiproses> {
  TextEditingController dateinput = TextEditingController();

  final _networkRepo = NetworkRepo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: dateinput,
              onTap: () {
                _selectDate();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              onChanged: (value){
                dateinput.text = value;
              },
              style: regular.copyWith(fontSize: 14.0),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xfff1f1f1),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none
                  ),
                  hintText: "Cari Tanggal Surat",
                  hintStyle: regular.copyWith(
                      letterSpacing: 0.5,
                      color: const Color(0xffdadada)
                  ),
                  prefixIcon: const Icon(Icons.date_range),
                  prefixIconColor: const Color(0xff888888)
              ),
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }

  Widget dataNoFoundWidget() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/no_data.svg', height: 100, width: 100),
          const SizedBox(height: 24),
          Text(
            'Tidak ada Surat ${widget.jenisSurat} ditemukan',
            style: regular.copyWith(
                color: secondaryBlueBlack, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Future _selectDate() async {
    var picked = await showDatePicker(context: context,
        initialDate:DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if(picked != null){
      setState(() {
        dateinput.text = formatTanggal(picked.toString());
        if(kDebugMode){
          print("Tanggal ${dateinput.text}");
        }
      });
    }
  }
}

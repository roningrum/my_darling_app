import 'package:flutter/material.dart';
import 'package:my_darling_app/page/home/edispo/surat_dispo_diproses_page.dart';

import '../../../theme/theme.dart';

class SuratDispo extends StatefulWidget {
  final String jenisSurat;
  const SuratDispo({Key? key, required this.jenisSurat}) : super(key: key);

  @override
  State<SuratDispo> createState() => _SuratDispoState();
}

class _SuratDispoState extends State<SuratDispo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(getPageTitle(widget.jenisSurat),style: title.copyWith(color: Colors.white, fontSize: 16)),
            backgroundColor: primaryBlueBlack,
            bottom: const TabBar(
              indicatorColor: Colors.redAccent,
              indicatorWeight: 2,
              tabs: [
                Tab(text: "Sudah Diproses"),
                Tab(text: "Belum Diproses")
              ],
            ),
          ),
        body: const TabBarView(
          children: [
            SuratDispoDiproses(keteranganProses:"Sudah Diproses"),
            SuratDispoDiproses(keteranganProses:"Belum Diproses"),
          ],
        ),
      ),
    );
  }

  //get Judul text
  String getPageTitle(String jenisSurat){
    if(jenisSurat == "umum"){
      return 'Surat Umum';
    }
    else if(jenisSurat == "undangan"){
      return 'Surat Undangan';
    }
    else{
      return 'Surat Dispo Balik';
    }
  }
}

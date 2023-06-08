import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/home/edispo/surat_dispo_diproses_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../theme/theme.dart';

class SuratDispo extends StatefulWidget {
  final String jenisSurat;
  final String rule;
  final String bidang;
  final String userId;
  final String seksi;

  const SuratDispo({Key? key, required this.jenisSurat, required this.rule, required this.bidang, required this.userId, required this.seksi}) : super(key: key);

  @override
  State<SuratDispo> createState() => _SuratDispoState();
}

class _SuratDispoState extends State<SuratDispo> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

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
        body: TabBarView(
          children: [
            SuratDispoDiproses(keteranganProses:"Sudah Diproses", jenisSurat: widget.jenisSurat, rule: widget.rule, bidang: widget.bidang, seksi: widget.seksi, userId: widget.userId),
            SuratDispoDiproses(keteranganProses:"Belum Diproses", jenisSurat: widget.jenisSurat, rule: widget.rule, bidang: widget.bidang, seksi: widget.seksi, userId: widget.userId),
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

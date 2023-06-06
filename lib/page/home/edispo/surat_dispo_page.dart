import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/home/edispo/surat_dispo_diproses_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../theme/theme.dart';

class SuratDispo extends StatefulWidget {
  final String jenisSurat;
  const SuratDispo({Key? key, required this.jenisSurat}) : super(key: key);

  @override
  State<SuratDispo> createState() => _SuratDispoState();
}

class _SuratDispoState extends State<SuratDispo> {
  final _sessionManager = SessionManager();
  String? rule;
  String? bidang;
  String? seksi;
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    iniateState();
    super.initState();

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
    });

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
            SuratDispoDiproses(keteranganProses:"Sudah Diproses", jenisSurat: widget.jenisSurat, rule: rule!, bidang: bidang!, seksi: seksi!, userId: userId!),
            SuratDispoDiproses(keteranganProses:"Belum Diproses", jenisSurat: widget.jenisSurat, rule: rule!, bidang: bidang!, seksi: seksi!, userId: userId!)
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

import 'package:flutter/material.dart';
import 'package:my_darling_app/page/home/edispo/surat_dispo_diproses_page.dart';

import '../../../theme/theme.dart';

class SuratDispo extends StatefulWidget {
  final String jenisSurat;
  final String rule;
  final String bidang;
  final String userId;
  final String seksi;

  final int totalSuratMasuk;

  const SuratDispo(
      {Key? key,
      required this.jenisSurat,
      required this.rule,
      required this.bidang,
      required this.userId,
      required this.seksi,
      this.totalSuratMasuk = 0})
      : super(key: key);

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
          title: Text(getPageTitle(widget.jenisSurat),
              style: title.copyWith(color: Colors.white, fontSize: 16)),
          backgroundColor: primaryBlueBlack,
          bottom: TabBar(
            indicatorColor: Colors.redAccent,
            indicatorWeight: 2,
            labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            tabs: [
              Tab(child: Row(
                children: [
                  const Text('Belum Diproses'),
                  Badge(
                    label: Text('${widget.totalSuratMasuk}'),
                  )
                ],)),
              const Tab(text: "Sudah Diproses"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SuratDispoDiproses(
                keteranganProses: "Belum Diproses",
                jenisSurat: widget.jenisSurat,
                rule: widget.rule,
                bidang: widget.bidang,
                seksi: widget.seksi,
                userId: widget.userId),
            SuratDispoDiproses(
                keteranganProses: "Sudah Diproses",
                jenisSurat: widget.jenisSurat,
                rule: widget.rule,
                bidang: widget.bidang,
                seksi: widget.seksi,
                userId: widget.userId),
          ],
        ),
      ),
    );
  }

  //get Judul text
  String getPageTitle(String jenisSurat) {
    if (jenisSurat == "umum") {
      return 'Surat Umum';
    } else if (jenisSurat == "undangan") {
      return 'Surat Undangan';
    } else {
      return 'Surat Dispo Balik';
    }
  }
}

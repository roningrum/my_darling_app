import 'package:flutter/material.dart';
import 'package:my_darling_app/page/suratdispo/surat_belum_diproses.dart';
import 'package:my_darling_app/page/suratdispo/surat_sudah_diproses.dart';
import 'package:my_darling_app/theme/theme.dart';

class SuratDispoDiproses extends StatefulWidget {
  final String keteranganProses;
  final String jenisSurat;
  final String rule;
  final String bidang;
  final String userId;
  final String seksi;

  const SuratDispoDiproses({Key? key,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Text(
              'Surat ${widget.jenisSurat} ${widget.keteranganProses}',
              style: title.copyWith(color: secondaryBlueBlack, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),
            widget.keteranganProses == "Sudah Diproses"
                ? SuratSudahDiproses(jenisSurat: widget.jenisSurat, rule: widget.rule, bidang: widget.bidang, userId: widget.userId, seksi: widget.seksi)
                : SuratBelumDiproses(jenisSurat: widget.jenisSurat, rule: widget.rule, bidang: widget.bidang, userId: widget.userId, seksi: widget.seksi)
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/model/surat_response.dart';
import 'package:my_darling_app/theme/theme.dart';

class SuratDetailPage extends StatefulWidget {
  final Surat surat;

  const SuratDetailPage({super.key, required this.surat});

  @override
  State<SuratDetailPage> createState() => _SuratDetailPageState();
}

class _SuratDetailPageState extends State<SuratDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlueBlack,
        title: Text(
          'Detail Surat',
          style: title.copyWith(color: white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.surat.acara}',
                style:
                    title.copyWith(color: secondaryBlueBlack, fontSize: 16.0),
                textAlign: TextAlign.center),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tgl Surat',
                    style: regular.copyWith(
                        color: secondaryBlueBlack, fontSize: 14.0),
                    textAlign: TextAlign.start),
                Text(dateFormat(widget.surat.tglSurat!),
                    style: regular.copyWith(
                        color: secondaryBlueBlack, fontSize: 14.0),
                    textAlign: TextAlign.start),
                const SizedBox(width: 4),
                Text('Tgl Terima',
                    style: regular.copyWith(
                        color: secondaryBlueBlack, fontSize: 14.0),
                    textAlign: TextAlign.start),
                Text(dateFormat(widget.surat.tglTerima!),
                    style: regular.copyWith(
                        color: secondaryBlueBlack, fontSize: 14.0),
                    textAlign: TextAlign.start),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('No. Surat',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.noSurat}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('No. Agenda',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.noAgenda}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Perihal',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.perihalSurat}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Dari',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.dari}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Tempat',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.tempat}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Tgl Acara',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text(
                        '${dateFormat(widget.surat.tanggal!)} s/d ${dateFormat(widget.surat.tanggal2!)}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Jam',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.jam} WIB',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 20.0),
            Text('Disposisi Surat',
                style: title.copyWith(
                    color: secondaryBlueBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Bidang',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.disposisi1}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Seksi',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.disposisi2}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Staff',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.disposisi3}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 16.0),
            Text('Keterangan Surat',
                style: title.copyWith(
                    color: secondaryBlueBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Isi',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.isiSurat}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Status Diposisi',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.statusDp}',
                        style: regular.copyWith(
                            color: widget.surat.statusDp == "proses"
                                ? Colors.orange.shade500
                                : Colors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Staff',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.surat.disposisi3}',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('File Surat',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                ElevatedButton.icon(
                    onPressed: (){
                      // final url = 'http://119.2.50.170:9095/e_dispo/assets/temp/file_surat/${widget.surat.fileSurat}';
                      // //buat lihat pdf / file scanned
                      // lihatFileSurat(widget.surat.fileSurat!);
                      // launchPdfUrl(Uri.parse(url));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
                    ),
                    icon: const Icon(Icons.remove_red_eye, size: 24.0,),
                    label: Text('Lihat Surat', style: title.copyWith(color: Colors.white),),)
              ],
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

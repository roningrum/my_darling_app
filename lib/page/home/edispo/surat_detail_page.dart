import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/page/home/edispo/file_surat_dispo.dart';
import 'package:my_darling_app/repository/model/surat_response.dart';
import 'package:my_darling_app/theme/theme.dart';

class SuratDetailPage extends StatefulWidget {
  final Surat surat;
  final String rulePegawai;

  const SuratDetailPage(
      {super.key, required this.surat, required this.rulePegawai});

  @override
  State<SuratDetailPage> createState() => _SuratDetailPageState();
}

class _SuratDetailPageState extends State<SuratDetailPage> {
  bool _isLoading = false;

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.surat.acara}',
                style:
                title.copyWith(color: secondaryBlueBlack, fontSize: 16.0),
                textAlign: TextAlign.center),
            const SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Tgl Surat',
                      style: regular.copyWith(
                          color: secondaryBlueBlack, fontSize: 14.0),
                      textAlign: TextAlign.start),
                ),
                Text(dateFormat(widget.surat.tglSurat!),
                    style: regular.copyWith(
                        color: secondaryBlueBlack, fontSize: 14.0),
                    textAlign: TextAlign.start),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Tgl Terima',
                      style: regular.copyWith(
                          color: secondaryBlueBlack, fontSize: 14.0),
                      textAlign: TextAlign.start),
                ),
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
                        '${dateFormat(widget.surat.tanggal)} s/d ${dateFormat(
                            widget.surat.tanggal2)}',
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            FileSuratDispo(fileSurat: widget.surat
                                .fileSurat!)));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff367588),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8)
                  ),
                  icon: const Icon(Icons.remove_red_eye, size: 24.0,),
                  label: Text('Lihat Surat',
                    style: title.copyWith(color: Colors.white),),)
              ],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
                width: 100,
                child: Text('Aksi',
                    style: title.copyWith(
                        color: secondaryBlueBlack, fontSize: 16.0),
                    textAlign: TextAlign.start)),
            const SizedBox(height: 16.0),
            Center(
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.spaceAround,
                spacing: MediaQuery
                    .of(context)
                    .size
                    .width * 0.20,
                runSpacing: 16,
                children: [

                  widget.rulePegawai == "staff" ? Container() : ElevatedButton
                      .icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        elevation: 0,
                        minimumSize: const Size(125, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8)
                    ),
                    icon: const Icon(Icons.edit_document, size: 24.0,),
                    label: Text(widget.surat.statusDp == "proses"
                        ? 'Disposisi'
                        : 'Edit Disposisi',
                      style: title.copyWith(color: Colors.white),),),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(context: context, builder: (context) =>
                          AlertDialog(

                            title: Text("Terima Surat",
                                style: title.copyWith(color: primaryBlueBlack)),
                            content: Text('Apakah yakin menerima surat ini?',
                                style: regular.copyWith(
                                    color: secondaryBlueBlack, fontSize: 14.0)),
                            actions: [
                              ElevatedButton(onPressed: () {
                                Navigator.pop(context);
                              },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                        side: const BorderSide(
                                            color: Color(0xff355BF5)
                                        )
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text('Batalkan',
                                    style: regular.copyWith(
                                        color: secondaryBlueBlack),)),
                              ElevatedButton(onPressed: () {
                                Navigator.pop(context);
                                _fetchData(context);
                              },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff355BF5),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text('Ya', style: regular)),
                            ],
                          )

                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff355BF5),
                        elevation: 0,
                        minimumSize: const Size(125, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8)
                    ),
                    icon: const Icon(Icons.mark_email_read, size: 24.0,),
                    label: Text('Terima Surat',
                      style: title.copyWith(color: Colors.white),),),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF9900),
                        elevation: 0,
                        minimumSize: const Size(125, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8)
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 24.0,),
                    label: Text('Dispo Balik',
                      style: title.copyWith(color: Colors.white),),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _fetchData(BuildContext context,  [bool mounted = true]) async{
  showDialog(barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: white,
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: primaryRed),
                const SizedBox(height: 10),
                Text("Mohon Tunggu Sebentar", style: regular)
              ],
            ),
          ),
        );
      });
  await Future.delayed(const Duration(seconds: 3));
  if (!mounted) return;
  Navigator.of(context).pop();
}

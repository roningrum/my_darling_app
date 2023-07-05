import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/page/home/edispo/file_surat_dispo.dart';
import 'package:my_darling_app/repository/model/Item_notulen_response.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NotulenDetail extends StatefulWidget {
  final ItemNotulen notulen;
  const NotulenDetail({super.key, required this.notulen});

  @override
  State<NotulenDetail> createState() => _NotulenDetailState();
}

class _NotulenDetailState extends State<NotulenDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notulen Detail',style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.notulen.acara}',
                style:
                title.copyWith(color: secondaryBlueBlack, fontSize: 16.0),
                textAlign: TextAlign.center),
            const SizedBox(height: 12.0),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text('Tgl Surat',
                      style: regular.copyWith(
                          color: secondaryBlueBlack, fontSize: 14.0),
                      textAlign: TextAlign.start),
                ),
                Text(dateFormat(widget.notulen.tglSurat!),
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
                Text(dateFormat(widget.notulen.tglTerima!),
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
                    child: Text('No.Agenda',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.notulen.noAgenda}',
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
                    child: Text('${widget.notulen.dari}',
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
                    child: Text('${widget.notulen.perihalSurat}',
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
                    child: Text('${widget.notulen.dari}',
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
                    child: Text('${widget.notulen.tempat}',
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
                        '${dateFormat(widget.notulen.tanggal)} s/d ${dateFormat(widget.notulen.tanggal2)}',
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
                    child: Text('${widget.notulen.jam} WIB',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Keterangan',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text('${widget.notulen.keterangan}',
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
                    child: Text('${widget.notulen.status}',
                        style: regular.copyWith(
                            color: widget.notulen.status == "proses"
                                ? Colors.orange.shade500
                                : Colors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FileSuratDispo(fileSurat: widget.notulen.fileSurat!)));
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
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('File Notulen',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                ElevatedButton.icon(
                  onPressed: () async{
                    var url = 'http://docs.google.com/viewer?url=http://119.2.50.170:9095/e_dispo/assets/temp/notulen/${widget.notulen.notulen}';
                    if(await canLaunchUrl(Uri.parse(url))){
                    await launchUrl(Uri.parse(url));
                    }
                    else{
                      throw 'Couldnt launch $url';
                    }
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
                  label: Text('Lihat Notulen', style: title.copyWith(color: Colors.white),),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openFileNotulen(String? fileSurat) async {

  }
}

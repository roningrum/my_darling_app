import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/model/kegiatan_internal_response.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class KegiatanPage extends StatefulWidget {
  final KegiatanInternal kegiatanInternal;
  const KegiatanPage({super.key, required this.kegiatanInternal});

  @override
  State<KegiatanPage> createState() => _KegiatanPageState();
}

class _KegiatanPageState extends State<KegiatanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlueBlack,
        title: Text(
          'Detail Kegiatan Bidang',
          style: title.copyWith(color: white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.kegiatanInternal.kegiatan}',
                style:
                title.copyWith(color: secondaryBlueBlack, fontSize: 16.0),
                textAlign: TextAlign.center),
            const SizedBox(height: 20.0),
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
                    child: Text('${widget.kegiatanInternal.lokasi}',
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
                        '${dateFormat(widget.kegiatanInternal.tglKegiatan)}',
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
                    child: Text('${widget.kegiatanInternal.jam}',
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
                    child: Text('${widget.kegiatanInternal.disposisi}',
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
                    child: Text('${widget.kegiatanInternal.deskripsi}',
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
                    child: Text('Dihadiri',
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
                Expanded(
                    child: Text(widget.kegiatanInternal.dihadiri =="" && widget.kegiatanInternal.dihadiri!=null?"-":"${widget.kegiatanInternal.dihadiri}",
                        style: regular.copyWith(
                            color: secondaryBlueBlack, fontSize: 14.0),
                        textAlign: TextAlign.start)),
              ],
            ),
            const SizedBox(height: 16.0),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    shareWhatsApp(widget.kegiatanInternal);
                  },
                  icon: Image.asset('assets/icons/edispo/whatsapp-share.png',
                      width: 24),
                  label: Text(
                    "Bagikan",
                    style: regular.copyWith(color: white),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      fixedSize: const Size(120, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: const Color(0xff25D366)),
                ))
          ],
        ),
      ),
    );
  }
  void shareWhatsApp(KegiatanInternal data) async {
    await WhatsappShare.share(
        phone: '62XXXXXXXXXX',
        text:
        "Agenda Tanggal : *${data.tglKegiatan}* \nAcara : *${data
            .kegiatan}* \nLokasi : *${data.lokasi}*  \nWaktu Acara : *${data
            .hari} ${data.tglKegiatan}* \nBidang : ${data
            .disposisi} \nHadir : ${data
            .dihadiri}\n\n(Data ini diambil dari aplikasi Mobile E-Disposisi)");
  }
}

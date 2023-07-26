import 'package:flutter/material.dart';
import 'package:my_darling_app/repository/model/agenda_surat_response.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class AgendaTodayItem extends StatefulWidget {
  final Data data;

  const AgendaTodayItem({required this.data, Key? key}) : super(key: key);

  @override
  State<AgendaTodayItem> createState() => _AgendaTodayItemState();
}

class _AgendaTodayItemState extends State<AgendaTodayItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.data.dari ?? "-",
              style: regular.copyWith(
                fontSize: 14.0,
              ),
              textAlign: TextAlign.start),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('${widget.data.acara}',
                          style: title.copyWith(
                              color: primaryBlueBlack, fontSize: 14.0)),
                      const SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Icon(Icons.location_on_sharp,
                                  color: primaryRed, size: 18.0)),
                          const WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: SizedBox(width: 10)),
                          TextSpan(
                              text: "${widget.data.tempat}",
                              style: regular.copyWith(
                                  color: primaryBlueBlack, fontSize: 14.0))
                        ]),
                      ),
                      const SizedBox(height: 4.0),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Icon(Icons.date_range,
                                  color: primaryRed, size: 16.0)),
                          const WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: SizedBox(width: 10)),
                          TextSpan(
                              text:
                                  "${widget.data.tanggal}(${widget.data.jam})",
                              style: regular.copyWith(
                                  color: primaryBlueBlack, fontSize: 14.0))
                        ]),
                      ),
                    ]),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 64,
                child: Text('Bidang',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text('${widget.data.disposisi1}',
                    style: regular.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 64,
                child: Text('Seksi',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text('${widget.data.disposisi2}',
                    style: regular.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 64,
                child: Text('Staff',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text('${widget.data.disposisi3}',
                    style: regular.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 64,
                child: Text('Hadir',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text('${widget.data.semuaPenerima}',
                    style: regular.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  shareAgenda(widget.data);
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
    );
  }

  Future<void> shareAgenda(Data data) async {
    await WhatsappShare.share(
        phone: '62XXXXXXXXXX',
        text:
            "Agenda Tanggal : *${data.tglTerima}* \nAcara : *${data.acara}* \nLokasi : *${data.tempat}* \nDari : *${data.dari}* \nBidang : ${data.disposisi1} \nSeksi : ${data.disposisi2} \nStaff : ${data.disposisi3} \nHadir : ${data.semuaPenerima} \n\n(Data ini diambil dari aplikasi Mobile E-Disposisi)");
  }
}

import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/theme/theme.dart';

import '../../repository/model/Kegiatan_pppk_response.dart';

class KegiatanPPPKItem extends StatelessWidget {
  final KegiatanPppk kegiatanPppk;
  const KegiatanPPPKItem({Key? key, required this.kegiatanPppk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                      Text('${kegiatanPppk.kegiatan}',
                          style: title.copyWith(
                              color: primaryBlueBlack, fontSize: 16.0)),
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
                              text: "${kegiatanPppk.lokasi}",
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
                              "${dateFormat(kegiatanPppk.tglKegiatan1)} s/d ${dateFormat(kegiatanPppk.tglKegiatan2)}",
                              style: regular.copyWith(
                                  color: primaryBlueBlack, fontSize: 14.0))
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Icon(Icons.watch_later_rounded,
                                  color: primaryRed, size: 16.0)),
                          const WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: SizedBox(width: 10)),
                          TextSpan(
                              text:
                              "${kegiatanPppk.jam} WIB",
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
                width: 100,
                child: Text('Penanggung Jawab',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text('${kegiatanPppk.penanggungJawab}',
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
                width: 100,
                child: Text('Pelaksana',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text('${kegiatanPppk.pelaksana}',
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
                width: 100,
                child: Text('Keterangan',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text('${kegiatanPppk.deskripsi}',
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
                onPressed: () {},
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
}

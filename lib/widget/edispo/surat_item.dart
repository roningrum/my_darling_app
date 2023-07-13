import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/model/surat_response.dart';

import '../../theme/theme.dart';

class SuratItem extends StatelessWidget {
  final Surat surat;
  const SuratItem({Key? key, required this.surat}) : super(key: key);

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
                      Text(surat.acara??"-",
                          style: title.copyWith(
                              color: primaryBlueBlack, fontSize: 16.0), maxLines: 3,),
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
                              text: surat.tempat??"-",
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
                              text: "${dateFormat(surat.tanggal)} s/d ${dateFormat(surat.tanggal2)} (${surat.jam ?? "-"})",
                              style: regular.copyWith(
                                  color: primaryBlueBlack, fontSize: 14.0))
                        ]),
                      ),
                    ]),
              )
            ],
          ),
          const SizedBox(height: 10.0),
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
                child: Text(surat.disposisi1 ??"-",
                    style: regular.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start, maxLines: 3),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
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
                child: Text(surat.disposisi2 ??"-",
                    style: regular.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start, maxLines: 3,),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
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
                child: Text(surat.disposisi2??"-",
                    style: regular.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start, maxLines: 2,),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
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
                child: Text(surat.isiSurat??"-",
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
                child: Text('Keterangan DispoBalik',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(surat.isiDp??"-",
                    style: regular.copyWith(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
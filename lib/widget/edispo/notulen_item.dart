import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/repository/model/Item_notulen_response.dart';
import 'package:my_darling_app/repository/model/surat_response.dart';

import '../../theme/theme.dart';


class NotulenItem extends StatelessWidget {
  final ItemNotulen notulen;
  const NotulenItem({super.key, required this.notulen});

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
                      Text(notulen.acara??"-",
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
                              text: notulen.tempat??"-",
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
                              text: "${dateFormat(notulen.tanggal)} s/d ${dateFormat(notulen.tanggal2)} (${notulen.jam ?? "-"})",
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
                child: Text('perihal',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(notulen.perihalSurat ??"-",
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
                child: Text('dari',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(notulen.dari??"-",
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
                child: Text('status',
                    style: title.copyWith(
                        fontSize: 14.0, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child:Text(notulen.status??"-",
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

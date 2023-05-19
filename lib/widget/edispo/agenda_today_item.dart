import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/repository/agenda_surat_response.dart';
import 'package:my_darling_app/theme/theme.dart';

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
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: greyColor, width: 2.0)),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
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
                        Text('${widget.data.acara}',
                            style: title.copyWith(
                                color: primaryBlueBlack, fontSize: 14.0)),
                        const SizedBox(height: 6.0),
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
                        const SizedBox(width: 8.0),
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
                        const SizedBox(width: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 64,
                    child: Expanded(
                      child: Text('Bidang',
                          style: title.copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Expanded(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 64,
                    child: Expanded(
                      child: Text('Seksi',
                          style: title.copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Expanded(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 64,
                    child: Expanded(
                      child: Text('Staff',
                          style: title.copyWith(
                              fontSize: 14.0, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Expanded(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 64,
                    child: Text('Hadir',
                        style: title.copyWith(
                            fontSize: 14.0, fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                    child: Text('${widget.data.semuaPenerima}',
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
        ),
      ),
    );
  }
}

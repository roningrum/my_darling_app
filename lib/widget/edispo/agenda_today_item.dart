import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/theme/theme.dart';

class AgendaTodayItem extends StatefulWidget {
  const AgendaTodayItem({Key? key}) : super(key: key);

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
            side: BorderSide(
                color: greyColor,
                width: 2.0
            )
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/edispo/today_agenda.svg',width: 24.0, height: 24.0),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Acara Hari Ini', style: title.copyWith(color: primaryBlueBlack, fontSize: 16.0)),
                      const SizedBox(height: 6.0),
                      Row(
                        children:[
                          RichText(
                            text: TextSpan(
                                children: [
                                  WidgetSpan(child:
                                  Icon(Icons.location_on_sharp, color: primaryRed, size: 16.0)
                                  ),
                                  TextSpan(
                                      text: "Acara Hari Ini", style: regular.copyWith(color: primaryBlueBlack, fontSize: 14.0)
                                  )
                                ]
                            ),
                          ),
                          const SizedBox( width: 8.0),
                          RichText(
                            text: TextSpan(
                                children: [
                                  WidgetSpan(child:
                                  Icon(Icons.date_range, color: primaryRed, size: 16.0)
                                  ),
                                  TextSpan(
                                      text: "Acara Hari Ini", style: regular.copyWith(color: primaryBlueBlack, fontSize: 14.0)
                                  )
                                ]
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Bidang', style: title.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500)),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text('Bidang', style: regular.copyWith(
                      fontSize: 14.0,
                    ), textAlign: TextAlign.start),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Seksi', style: title.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500)),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text('Bidang', style: regular.copyWith(
                      fontSize: 14.0,
                    ), textAlign: TextAlign.start),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Staff', style: title.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500)),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text('Bidang', style: regular.copyWith(
                      fontSize: 14.0,
                    ), textAlign: TextAlign.start),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Text('Hadir', style: title.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500)),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text('Bidang', style: regular.copyWith(
                      fontSize: 14.0,
                    ), textAlign: TextAlign.start),
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

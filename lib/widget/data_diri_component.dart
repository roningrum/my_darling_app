import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_darling_app/const.dart';

class DataDiriComponent extends StatelessWidget {
  final String iconData;
  final String labelData;
  final String isiData;

  const DataDiriComponent({Key? key, required this.iconData, required this.labelData, required this.isiData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SvgPicture.asset(iconData, width: 24),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(labelData, style: bodyTextStyle.copyWith(fontSize: 12, color: primaryColor)),
              Text(isiData, style: bodyTextStyle.copyWith(fontSize: 14, color: primaryColor, fontWeight: FontWeight.w600)),
            ],
          )
        ],
      ),
    );
  }
}

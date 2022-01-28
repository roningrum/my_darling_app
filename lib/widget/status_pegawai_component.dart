import 'package:flutter/material.dart';

import '../const.dart';

class StatusPegawaiComponent extends StatelessWidget {
  final String labelData;
  final String isiData;

  const StatusPegawaiComponent({Key? key, required this.labelData, required this.isiData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(labelData, style: bodyTextStyle.copyWith(fontSize: 12, color: primaryColor)),
          SizedBox(height: 4),
          Text(isiData, style: bodyTextStyle.copyWith(fontSize: 14, color: primaryColor, fontWeight: FontWeight.w600)),
        ],
      )
    );
  }
}

import 'package:flutter/material.dart';

import '../const.dart';

class HomeMenuComponent extends StatelessWidget {
  final String nameMenu;
  final String iconMenu;
  // final String iconMenu;

  const HomeMenuComponent( {Key?key,  required this.nameMenu, required this.iconMenu}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Image.asset(iconMenu, width: 72, height: 72),
          SizedBox(height: 4),
          Text(nameMenu, style: subtitleTextStyle.copyWith(fontSize: 14), textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}

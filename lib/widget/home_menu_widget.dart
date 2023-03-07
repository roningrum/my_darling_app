import 'package:flutter/material.dart';
import 'package:my_darling_app/theme/theme.dart';

class HomeMenuWidget extends StatelessWidget {
  final String namaMenu;
  final String logoMenu;

  const HomeMenuWidget(this.namaMenu, this.logoMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 72.0,
          height: 72.0,
          decoration: BoxDecoration(
            color: white,
            border: Border.all(
              width: 1,
              color: greyColor
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16.0))
          ),
          child: Center(child: Image.asset(logoMenu, width: 40.0, height: 40.0, fit: BoxFit.contain,)),
        ),
        const SizedBox(height: 4),
        Text(namaMenu, style: regular.copyWith(fontSize: 12, color: secondaryBlueBlack),),
        const SizedBox(height: 4),
      ],
    );
  }
}

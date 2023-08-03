import 'package:flutter/material.dart';
import 'package:my_darling_app/theme/theme.dart';

class PekundenMenuWidget extends StatelessWidget {
  final String namaMenu;
  final String logoMenu;

  const PekundenMenuWidget(this.namaMenu, this.logoMenu, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                color:  Colors.black12,
                width: 1
            ),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(logoMenu, width: 32.0, height: 32.0, fit: BoxFit.cover,),
              ),
              const SizedBox(height: 4),
              Text(namaMenu, style: regular.copyWith(fontSize: 14.0, color: secondaryBlueBlack), textAlign: TextAlign.center,),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

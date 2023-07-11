import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/theme/theme.dart';

class AkmRiwayatWidget extends StatefulWidget {
  const AkmRiwayatWidget({super.key});

  @override
  State<AkmRiwayatWidget> createState() => _AkmRiwayatWidgetState();
}

class _AkmRiwayatWidgetState extends State<AkmRiwayatWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12.0),
        scanBarcodeAKM(),
        const SizedBox(height: 8.0),
        Text(
          'Test',
          style: regular.copyWith(fontSize: 14.0, color: Colors.black),
        )
      ],
    );
  }

  Widget scanBarcodeAKM() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(width: 3, color: const Color(0xffe1e1e1)),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: primaryBlueBlack,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Klik disini untuk scan barcode',
                    style: title.copyWith(fontSize: 16.0, color: white)),
                SvgPicture.asset('assets/icons/qrcode.svg',
                    width: 45.0, height: 45.0)
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
              'Data Checkup Kesehatan (Menggunakan Mesin Anjungan Kesehatan Mandiri',
              style: regular.copyWith(fontSize: 14.0),
              textAlign: TextAlign.center),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Berat Badan", style: regular.copyWith(fontSize: 14.0)),
                  const SizedBox(height: 8.0),
                  SvgPicture.asset("assets/icons/weight.svg",
                      width: 60, height: 60),
                  const SizedBox(height: 8.0),
                  Text("Kg", style: regular.copyWith(fontSize: 14.0)),
                ],
              ),
              Column(
                children: [
                  Text("Tinggi Badan", style: regular.copyWith(fontSize: 14.0)),
                  const SizedBox(height: 8.0),
                  SvgPicture.asset("assets/icons/body.svg",
                      width: 60, height: 60),
                  const SizedBox(height: 8.0),
                  Text("cm", style: regular.copyWith(fontSize: 14.0)),
                  TextButton(onPressed: (){}, child:Text("Riwayat", style: regular.copyWith(fontSize: 14.0, color: primaryRed, fontWeight: FontWeight.w600)) )
                ],
              ),
              Column(
                children: [
                  Text("Hasil Tensi", style: regular.copyWith(fontSize: 14.0)),
                  const SizedBox(height: 8.0),
                  SvgPicture.asset("assets/icons/blood_pressure.svg",
                      width: 60, height: 60),
                  const SizedBox(height: 8.0),
                  Text("mm/Hg", style: regular.copyWith(fontSize: 14.0)),
                  TextButton(onPressed: (){}, child:Text("Riwayat", style: regular.copyWith(fontSize: 14.0, color: primaryRed, fontWeight: FontWeight.w600)) )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

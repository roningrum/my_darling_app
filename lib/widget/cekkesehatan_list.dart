import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_darling_app/theme/theme.dart';

import '../repository/model/catatan_kesehatan_response.dart';

class CekKesehatanWidget extends StatelessWidget {
  final CatatanKesehatanResponse catatanKesehatanResponse;
  final String nama;

  const CekKesehatanWidget({
    Key? key, required this.catatanKesehatanResponse, required this.nama,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Catatan Kesehatan ${catatanKesehatanResponse.nama}",
            style: title.copyWith(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Tanggal Periksa : ${catatanKesehatanResponse.tglPemeriksa}",
            style: title.copyWith(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.grey, width: 1),
              borderRadius: const BorderRadius.all(
                  Radius.circular(8.0) //                 <--- border radius here
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    detailDataKesehatan("Tinggi\nBadan", "${catatanKesehatanResponse.tb}"),
                    const SizedBox(height: 10.0),
                    detailDataKesehatan("Berat\nBadan", "${catatanKesehatanResponse.bb}"),
                    const SizedBox(height: 10.0),
                  ],
                ),
                SvgPicture.asset('assets/icons/body.svg', width: 72, height: 72),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    detailDataKesehatan("Lingkar\nPinggang", "${catatanKesehatanResponse.lp}"),
                    const SizedBox(height: 10.0),
                    detailDataKesehatan("Indeks\nIdeal", "${catatanKesehatanResponse.imt}"),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.grey, width: 1),
              borderRadius: const BorderRadius.all(
                  Radius.circular(8.0) //                 <--- border radius here
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    detailDataKesehatan("Sistol", "${catatanKesehatanResponse.sistole}"),
                    const SizedBox(height: 10.0),
                    detailDataKesehatan("Diastol", "${catatanKesehatanResponse.diastole}"),
                    const SizedBox(height: 10.0),
                  ],
                ),
                SvgPicture.asset('assets/icons/blood_pressure.svg', width: 72, height: 72),
                Column(
                  children: [
                    detailDataKesehatan("Gula Darah", "${catatanKesehatanResponse.gulaDarah}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget detailDataKesehatan(String record, String namaRecord){
    return Column(
      children: [
        Text(
          record,
          style: regular.copyWith(fontSize: 12.0, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        Text(
          namaRecord,
          style: title.copyWith(fontSize: 18.0, color: secondaryBlueBlack),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_darling_app/widget/status_pegawai_component.dart';

class StatusTabView extends StatelessWidget {
  const StatusTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 24, top: 8),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            StatusPegawaiComponent(labelData: 'Status Pegawai', isiData: 'PNS'),
            StatusPegawaiComponent(labelData: 'Jabatan', isiData: 'Gol IIIA'),
            StatusPegawaiComponent(labelData: 'Nama Jabatan', isiData: 'Kasubag'),
            StatusPegawaiComponent(labelData: 'Unit Kerja', isiData: 'Sie Informasi'),
            StatusPegawaiComponent(labelData: 'Bidang', isiData: 'Humas'),
            StatusPegawaiComponent(labelData: 'Lokasi', isiData: 'Dinas Kesehatan Kota Semarang'),
          ],
        ),
      ),
    );
  }
}

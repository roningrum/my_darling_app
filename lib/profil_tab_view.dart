import 'package:flutter/material.dart';
import 'package:my_darling_app/widget/data_diri_component.dart';

class ProfilTabView extends StatelessWidget {
  const ProfilTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:const[
          DataDiriComponent(iconData: 'assets/images/icons/badge.svg', labelData: 'Nomor Induk Kepegawaian', isiData: '312345600987'),
          DataDiriComponent(iconData: 'assets/images/icons/person.svg', labelData: 'Nama', isiData: 'John Slamet'),
          DataDiriComponent(iconData: 'assets/images/icons/school.svg', labelData: 'Gelar Depan', isiData: 'Ir'),
          DataDiriComponent(iconData: 'assets/images/icons/school.svg', labelData: 'Gelar Belakang', isiData: 'S.M, M.M'),
          DataDiriComponent(iconData: 'assets/images/icons/calendar.svg', labelData: 'Tanggal Lahir', isiData: '16/12/1989'),
          DataDiriComponent(iconData: 'assets/images/icons/address.svg', labelData: 'Alamat', isiData: 'Jl. Taman Mekarsari'),
          DataDiriComponent(iconData: 'assets/images/icons/hp.svg', labelData: 'No.HP', isiData: '085789000000'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo_menu_widget.dart';
class Edispo extends StatefulWidget {
  const Edispo({Key? key}) : super(key: key);

  @override
  State<Edispo> createState() => _EdispoState();
}

class _EdispoState extends State<Edispo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edispo',style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body: Container(
        color: primaryBlueBlack,
        height: 400.0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: white,
            borderRadius: BorderRadius.circular(10.0)
          ),

          child:Wrap(
            alignment: WrapAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  EdispoMenuWidget('Surat Undangan','assets/icons/edispo/ic_undangan.png'),
                  EdispoMenuWidget('Surat Umum', 'assets/icons/edispo/ic_surat_umum.png'),
                  EdispoMenuWidget('Dispo Balik', 'assets/icons/edispo/ic_dispo_balik.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  EdispoMenuWidget('Kegiatan Internal', 'assets/icons/edispo/ic_agenda_internal.png'),
                  EdispoMenuWidget('Kegiatan Luar', 'assets/icons/edispo/ic_agenda_luar.png'),
                  EdispoMenuWidget('Kegiatan PPPK', 'assets/icons/edispo/ic_pppk.png'),
                ],
              ),
              const EdispoMenuWidget('Notulen', 'assets/icons/edispo/ic_undangan.png'),
            ],
          ),
        ),
      )
    );
  }

  //menu e-dispo

}

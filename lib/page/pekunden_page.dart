import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:my_darling_app/widget/edispo_menu_widget.dart';

import '../theme/theme.dart';

class PekundenPage extends StatefulWidget {
  const PekundenPage({Key? key}) : super(key: key);

  @override
  State<PekundenPage> createState() => _PekundenPageState();
}

class _PekundenPageState extends State<PekundenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pekunden Page',
            style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  const EdispoMenuWidget('Pelayanan Pekunden','assets/icons/ic_pekunden_file.png'),
                  GestureDetector(
                      onTap: (){
                        whatsAppKepegawaian();
                      },
                      child: const EdispoMenuWidget('Whatsapp Layanan Pekunded','assets/icons/whatsapp.png')),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> whatsAppKepegawaian() async{
    await launch('https://wa.me/62895640500605');
  }
}

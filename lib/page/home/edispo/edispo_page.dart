import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/home/edispo/edispo_agenda/edispo_agenda_page.dart';
import 'package:my_darling_app/page/home/edispo/kegiatan_external_bidang.dart';
import 'package:my_darling_app/page/home/edispo/kegiatan_internal_bidang.dart';
import 'package:my_darling_app/page/home/edispo/kegiatan_pppk_page.dart';
import 'package:my_darling_app/page/home/edispo/notulen.dart';
import 'package:my_darling_app/page/home/edispo/surat_dispo_page.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo_menu_widget.dart';

class Edispo extends StatefulWidget {
  const Edispo({Key? key}) : super(key: key);

  @override
  State<Edispo> createState() => _EdispoState();
}

class _EdispoState extends State<Edispo> {
  
  final networkRepo = NetworkRepo();
  final _sessionManager = SessionManager();

  String rule ="";
  String bidang = "";
  String seksi ="";
  String userId="";

  Future<void> iniateState() async {
    var ruleLocale = await _sessionManager.getRule('rule');
    var bidangLocale = await _sessionManager.getBidang('bidang');
    var seksiLocale = await _sessionManager.getSeksi('seksi');
    var userIdLocale = await _sessionManager.getUserId('userId');

    setState(() {
      rule = ruleLocale!;
      bidang = bidangLocale!;
      seksi = seksiLocale!;
      userId = userIdLocale!;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iniateState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edispo',style: title.copyWith(color: Colors.white, fontSize: 16)),
        backgroundColor: primaryBlueBlack,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: edispoMenu(),
          ),
          const SliverToBoxAdapter(
              child: EdispoAgendaPage()
          ),

        ],
      )
    );
  }

  //menu e-dispo
  Widget edispoMenu(){
    return Container(
      color: primaryBlueBlack,
      height: 400.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10.0)
        ),

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SuratDispo(jenisSurat: "undangan", rule: rule, bidang: bidang, seksi: seksi, userId: userId,)));
                    },
                    child: const EdispoMenuWidget('Surat Undangan','assets/icons/edispo/ic_undangan.png')),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>SuratDispo(jenisSurat: "umum", rule: rule, bidang: bidang, seksi: seksi, userId: userId,)));
                    },
                    child: const EdispoMenuWidget('Surat Umum','assets/icons/edispo/ic_surat_umum.png')),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SuratDispo(jenisSurat: "dispobalik", rule: rule, bidang: bidang, seksi: seksi, userId: userId,)));
                    },
                    child: const EdispoMenuWidget('Dispo Balik','assets/icons/edispo/ic_dispo_balik.png'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const KegiatanInternalBidang()));
                    },
                    child: const EdispoMenuWidget('Kegiatan\nInternal','assets/icons/edispo/ic_agenda_internal.png')),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const KegiatanExternalBidang()));
                    },
                    child: const EdispoMenuWidget('Kegiatan\nLuar','assets/icons/edispo/ic_agenda_luar.png')),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const KegiatanPPPKPage()));
                    },
                    child: const EdispoMenuWidget('Kegiatan\nPPPK','assets/icons/edispo/ic_pppk.png')),
              ],
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Notulen(userId: userId)));
                },
                child: const EdispoMenuWidget('Notulen', 'assets/icons/edispo/note.png')),

          ],
        ),
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/date_helper.dart';
import 'package:my_darling_app/page/home/edispo/edispo_agenda/edispo_agenda_page.dart';
import 'package:my_darling_app/page/home/edispo/kegiatan_external_bidang.dart';
import 'package:my_darling_app/page/home/edispo/kegiatan_internal_bidang.dart';
import 'package:my_darling_app/page/home/edispo/kegiatan_pppk_page.dart';
import 'package:my_darling_app/page/home/edispo/notulen.dart';
import 'package:my_darling_app/page/home/edispo/surat_dispo_page.dart';
import 'package:my_darling_app/repository/agenda_surat_response.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/edispo/agenda_today_item.dart';
import 'package:my_darling_app/widget/edispo_menu_widget.dart';

class Edispo extends StatefulWidget {
  const Edispo({Key? key}) : super(key: key);

  @override
  State<Edispo> createState() => _EdispoState();
}

class _EdispoState extends State<Edispo> {
  
  final networkRepo = NetworkRepo();

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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SuratDispo(jenisSurat: "undangan")));
                    },
                    child: const EdispoMenuWidget('Surat Undangan','assets/icons/edispo/ic_undangan.png')),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SuratDispo(jenisSurat: "umum")));
                    },
                    child: const EdispoMenuWidget('Surat Umum','assets/icons/edispo/ic_surat_umum.png')),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SuratDispo(jenisSurat: "dispo balik")));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Notulen()));
                },
                child: const EdispoMenuWidget('Notulen', 'assets/icons/edispo/note.png')),

          ],
        ),
      ),
    );
  }

  Widget edispoAgendaToday(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Agenda Hari Ini', style: regular.copyWith(color: secondaryBlueBlack, fontWeight: FontWeight.w600),),
              TextButton.icon(
                  onPressed:(){},
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
                    if(states.contains(MaterialState.pressed)){
                    return const Color(0xffF5D2D2).withOpacity(0.25);
                    }
                    return null;
                  })
                ),
                label: Text('Cari Agenda', style: regular.copyWith(color: primaryRed, fontWeight: FontWeight.w600)),
                icon: const Icon(
                  Icons.search,
                  size: 24.0,
                  color: Color(0xffD72323),
                ),
              )
            ],
          ),
          FutureBuilder<List<Data>>(
            future: networkRepo.getAgenda(getTodayDate(), getTodayDate()),
            builder: (context, snapshot){
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                if(snapshot.data!.isNotEmpty){
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length ,
                    itemBuilder: (context, index){
                      var data = snapshot.data?[index];
                      return AgendaTodayItem(data: data!);
                    },
                  );
                }
                else{
                  return Center(
                    child: Text("Tidak ada Agenda hari ini",
                        style: regular.copyWith(
                            fontSize: 14.0, color: secondaryBlueBlack)),
                  );
                }
              }
              else if(snapshot.hasError && snapshot.connectionState == ConnectionState.none){
                return Center(
                  child: Text("Cek Koneksi Kembali",
                      style: regular.copyWith(
                          fontSize: 14.0, color: secondaryBlueBlack)),
                );
              }
              else{
                return CircularProgressIndicator(color: primaryRed);
              }
              // return ListView(
              //   scrollDirection: Axis.vertical,
              //
              //   children: const [
              //     AgendaTodayItem(),
              //     AgendaTodayItem(),
              //     AgendaTodayItem(),
              //     AgendaTodayItem(),
              //     AgendaTodayItem(),
              //     AgendaTodayItem(),
              //     AgendaTodayItem(),
              //     AgendaTodayItem(),
              //   ],
              // )
            },
          )

        ],
      ),
    );
  }

}

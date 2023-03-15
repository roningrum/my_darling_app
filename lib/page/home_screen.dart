import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/home/edispo/edispo_page.dart';
import 'package:my_darling_app/page/login_screen.dart';
import 'package:my_darling_app/pedometer_page/pedometer_screen.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/home_artikel_berita_item.dart';
import 'package:my_darling_app/widget/home_menu_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../network_provider/NetworkRepository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _networkRepo = NetworkRepository();
  final _sessionManager = SessionManager();
  late String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        toolbarHeight: 56.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text('MyDarling', style: title.copyWith(color: primaryRed, fontSize: 18)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: (){
                  setState(() {
                    logout();
                  });
                },
                child: Image.asset('assets/image/user-photo.png', width: 40.0, height: 40.0,)),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: _sessionManager.readNama('nama'),
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selamat Pagi, ${snapshot.data}', style:title.copyWith(fontSize: 16.0, color: primaryBlueBlack)),
                      InkWell(child: bannerWalking(), onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PedometerScreen()));
                      }),
                      const SizedBox(
                        height: 24.0,
                      ),
                      homeMenu()

                    ],
                  ),
                );
              }
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Artikel Berita', style:title.copyWith(fontSize: 16.0, color: primaryBlueBlack)),
                  const SizedBox(
                    height: 24.0,
                  ),
                  homeArtikel(),
                  const SizedBox(
                    height: 24.0,
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  //Widget untuk step walking
  Widget bannerWalking(){
    return Container(
      width: MediaQuery.of(context).size.width -16,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            primaryRed,
            primaryBlueBlack
          ]
        ),
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
              children: [
                SvgPicture.asset('assets/icons/walking.svg',width: 24.0, height: 24.0),
                const SizedBox(width: 6.0),
                Text('Langkah Hari Ini', style: regular.copyWith(fontSize: 12.0, color: white))
              ],
            ),
              const SizedBox(height: 12.0),
              Column(
               crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('200', style: TextStyle(color: Colors.white, fontSize: 40.0, fontFamily: 'Roboto Slab', fontWeight: FontWeight.w600),),
                  Column(
                    children: [
                      Center(child: Text('20%', style: regular.copyWith(fontSize: 12.0, color: white), textAlign: TextAlign.center)),
                      LinearPercentIndicator(
                        backgroundColor: Colors.white,
                          animation: true,
                          animationDuration: 1000,
                          width: 160,
                          lineHeight: 12.0,
                          percent:20/100,
                        progressColor: const Color(0xff0CB061),
                        barRadius: const Radius.circular(8.0)
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  )
                ],
              ),

            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/waktu.svg',width: 24.0, height: 24.0),
                  const SizedBox(width:6.0),
                  Text('00:01:05', style: regular.copyWith(fontSize: 14.0, color: white))
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/kalori.svg',width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Text('245 Kal', style: regular.copyWith(fontSize: 12.0, color: white))
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/jalan.svg',width: 24.0, height: 24.0),
                  const SizedBox(width: 6.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Target', style: regular.copyWith(fontSize: 10.0, color: white)),
                      const SizedBox(height: 4.0),
                      Text('10000', style: regular.copyWith(fontSize: 14.0, color: white)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Widget untuk HomeMenu
  Widget homeMenu(){
    return Wrap(
      children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Edispo()));
                },
                child: const HomeMenuWidget('E-Dispo', 'assets/icons/edispo_menu.png')),
            const HomeMenuWidget('PerfomaKu','assets/icons/performance_menu.png'),
            const HomeMenuWidget('GajiKu', 'assets/icons/gajiku_menu.png'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            HomeMenuWidget('Pengajuan\nCuti', 'assets/icons/cuti_menu.png'),
            HomeMenuWidget('CekKesehatan', 'assets/icons/cek_kesehatan_menu.png'),
            HomeMenuWidget('Keluhan', 'assets/icons/keluhan_menu.png'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            HomeMenuWidget('SIMPATIK', 'assets/icons/simpatik_menu.png'),
            HomeMenuWidget('DinkesApp', 'assets/icons/dinkesapp_menu.png'),
            HomeMenuWidget('Hiburan', 'assets/icons/hiburan_app.png'),
          ],
        ),
      ],
    );
  }

  //Widget untuk Artikel Berita
  Widget homeArtikel(){
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HomeArtikelBeritaItem('Peleburan Eijkman ke BRIN, Birokratis', 'Peleburan Lembaga Biologi Molekuler Eijkman dan bagian riset Kapal Baruna menuai kritik publik..', 'assets/image/dummy-image.png'),
          HomeArtikelBeritaItem('Peleburan Eijkman ke BRIN, Birokratis', 'Peleburan Lembaga Biologi Molekuler Eijkman dan bagian riset Kapal Baruna menuai kritik publik..', 'assets/image/dummy-image.png'),
          HomeArtikelBeritaItem('Peleburan Eijkman ke BRIN, Birokratis', 'Peleburan Lembaga Biologi Molekuler Eijkman dan bagian riset Kapal Baruna menuai kritik publik..', 'assets/image/dummy-image.png'),
          HomeArtikelBeritaItem('Peleburan Eijkman ke BRIN, Birokratis', 'Peleburan Lembaga Biologi Molekuler Eijkman dan bagian riset Kapal Baruna menuai kritik publik..', 'assets/image/dummy-image.png'),
        ],
      ),
    );

}

  void logout() async{
    var token = await _sessionManager.readToken('token');
    if (kDebugMode) {
      print('token saat ini: $token');
    }
    var response = await _networkRepo.doLogout(token!);
    setState(() {
      if(response.status == 'sukses'){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const LoginScreen()), (_)=>false);
        Fluttertoast.showToast(msg: response.pesan!, toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    });
  }
}

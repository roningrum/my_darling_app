import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/home/edispo/edispo_page.dart';
import 'package:my_darling_app/page/home_banner_walking.dart';
import 'package:my_darling_app/page/login_screen.dart';
import 'package:my_darling_app/pedometer_page/pedometer_screen.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/home_artikel_berita_item.dart';
import 'package:my_darling_app/widget/home_menu_widget.dart';

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
          child: Text('MyDarling',
              style: title.copyWith(color: primaryRed, fontSize: 18)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    logout();
                  });
                },
                child: Image.asset(
                  'assets/image/user-photo.png',
                  width: 40.0,
                  height: 40.0,
                )),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selamat Pagi, user',
                    style: title.copyWith(
                        fontSize: 16.0, color: primaryBlueBlack)),
                const HomeBannerWalking(),
                const SizedBox(
                  height: 24.0,
                ),
                homeMenu()
              ],
            ),
          )),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Artikel Berita',
                      style: title.copyWith(
                          fontSize: 16.0, color: primaryBlueBlack)),
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

  //Widget untuk HomeMenu
  Widget homeMenu() {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Edispo()));
                },
                child: const HomeMenuWidget(
                    'E-Dispo', 'assets/icons/edispo_menu.png')),
            const HomeMenuWidget(
                'PerfomaKu', 'assets/icons/performance_menu.png'),
            const HomeMenuWidget('GajiKu', 'assets/icons/gajiku_menu.png'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            HomeMenuWidget('Pengajuan\nCuti', 'assets/icons/cuti_menu.png'),
            HomeMenuWidget(
                'CekKesehatan', 'assets/icons/cek_kesehatan_menu.png'),
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
  Widget homeArtikel() {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          HomeArtikelBeritaItem(
              'Peleburan Eijkman ke BRIN, Birokratis',
              'Peleburan Lembaga Biologi Molekuler Eijkman dan bagian riset Kapal Baruna menuai kritik publik..',
              'assets/image/dummy-image.png'),
          HomeArtikelBeritaItem(
              'Peleburan Eijkman ke BRIN, Birokratis',
              'Peleburan Lembaga Biologi Molekuler Eijkman dan bagian riset Kapal Baruna menuai kritik publik..',
              'assets/image/dummy-image.png'),
          HomeArtikelBeritaItem(
              'Peleburan Eijkman ke BRIN, Birokratis',
              'Peleburan Lembaga Biologi Molekuler Eijkman dan bagian riset Kapal Baruna menuai kritik publik..',
              'assets/image/dummy-image.png'),
          HomeArtikelBeritaItem(
              'Peleburan Eijkman ke BRIN, Birokratis',
              'Peleburan Lembaga Biologi Molekuler Eijkman dan bagian riset Kapal Baruna menuai kritik publik..',
              'assets/image/dummy-image.png'),
        ],
      ),
    );
  }

  void logout() async {
    var token = await _sessionManager.readToken('token');
    if (kDebugMode) {
      print('token saat ini: $token');
    }
    var response = await _networkRepo.doLogout(token!);
    setState(() {
      if (response.status == 'sukses') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (_) => false);
        // Fluttertoast.showToast(
        //     msg: response.pesan!,
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:my_darling_app/const.dart';
import 'package:my_darling_app/profil_tab_screen.dart';
import 'package:my_darling_app/widget/home_menu_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Container(
          margin: const EdgeInsets.all(24.0),
          child: Text('MyDarling', style: titleText.copyWith(fontSize: 16, color: redColor)),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/user_pic.png', width: 32),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            SizedBox(height: 32),
            Text('Hi, Slamet', style: titleText.copyWith(fontSize: 20, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('Selamat Pagi', style: titleText.copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
            SizedBox(height: 32),
            getHomeMenu(),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Artikel Berita', style: titleText.copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
                Text('Lihat Semua', style: bodyTextStyle.copyWith(fontSize: 12)),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget getHomeMenu(){
    return Column(
      children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            GestureDetector(
              onTap: (){
                setState(() {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilTabScreen())
                  );
                });
              },
                child: HomeMenuComponent(nameMenu: 'Profil', iconMenu: 'assets/images/profil.png')),
            HomeMenuComponent(nameMenu: 'Perfomaku', iconMenu: 'assets/images/performa.png'),
            HomeMenuComponent(nameMenu: 'GajiKu', iconMenu: 'assets/images/gajiku.png'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:const [
            HomeMenuComponent(nameMenu: 'Cuti', iconMenu: 'assets/images/cuti.png'),
            HomeMenuComponent(nameMenu: 'CekKesehatan', iconMenu: 'assets/images/kesehatan.png'),
            HomeMenuComponent(nameMenu: 'Keluhan', iconMenu: 'assets/images/keluhan.png'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:const [
            HomeMenuComponent(nameMenu: 'Simpatik', iconMenu: 'assets/images/simpatik.png'),
            HomeMenuComponent(nameMenu: 'DinkesApp', iconMenu: 'assets/images/dinkes_app.png'),
            HomeMenuComponent(nameMenu: 'Hiburan', iconMenu: 'assets/images/hiburan.png'),
          ],
        ),
      ],
    );
  }
}

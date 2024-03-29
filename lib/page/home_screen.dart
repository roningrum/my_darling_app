import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/home/edispo/edispo_page.dart';
import 'package:my_darling_app/page/home_banner_walking.dart';
import 'package:my_darling_app/repository/network_repo.dart';
import 'package:my_darling_app/theme/theme.dart';
import 'package:my_darling_app/widget/home_artikel_berita_item.dart';
import 'package:my_darling_app/widget/home_menu_widget.dart';

class HomeScreen extends StatefulWidget {
  final String nama;
  const HomeScreen({Key? key, required this.nama}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _networkRepo = NetworkRepo();
  final _sessionManager = SessionManager();
  late String token;
  String? userId;
  late String urlPhoto;


  //get Url_Photo
  Future<String> getUrlPhotoUser() async{
    userId = await _sessionManager.getUserId('userId');
    var response = await _networkRepo.getUserProfile(userId!);
    final user_photo = response[0].foto;
    urlPhoto = 'http://119.2.50.170:9095/e_dispo/assets/temp/foto/${user_photo}';
    return urlPhoto;
  }

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
            padding: const EdgeInsets.only(right: 24.0, top: 8.0),
            child: FutureBuilder<String>(
              future: getUrlPhotoUser(),
              builder: (context, snapshot){
                var data = snapshot.data!;
                if(snapshot.hasData){
                  return CachedNetworkImage(
                    imageUrl: data,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => Image.asset(
                      'assets/image/user-photo.png',
                      width: 50.0,
                      height: 50.0,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/image/user-photo.png',
                      width: 50.0,
                      height: 50.0,
                    ) ,
                  );
                }
                else{
                 return Image.asset(
                    'assets/image/user-photo.png',
                    width: 40.0,
                    height: 40.0,
                  );
                }
              },

            ))
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
                Text('Selamat Pagi, ${widget.nama}',
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
    return Center(
      child:
        Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Edispo()));
                },
                child: const HomeMenuWidget('E-Dispo','assets/icons/e-dispo.png')),
            GestureDetector(
                onTap: (){
                  launchNavara();
                },
                child: const HomeMenuWidget('Navara','assets/icons/navara.png')),
            GestureDetector(
                onTap: (){
                  whatsAppAmbulance();
                },
                child: const HomeMenuWidget('Ambulance\nHebat','assets/icons/ambulanceHebat.png')),
            const HomeMenuWidget('Kesehatan','assets/icons/cek_kesehatan_menu.png'),
            GestureDetector(
                onTap: (){
                  whatsAppKepegawaian();
                },
                child: const HomeMenuWidget('Kepegawaian','assets/icons/keluhan_menu.png')),
            GestureDetector(
                onTap: (){
                  launchSIMPATIK();
                },
                child: const HomeMenuWidget('SIMPATIK','assets/icons/simpatik_menu.png')),
            GestureDetector(
                onTap: (){
                  launchDinkesApp();
                },
                child: const HomeMenuWidget('DinkesApp','assets/icons/dinkesapp_menu.png')),
            const HomeMenuWidget('Hiburan','assets/icons/hiburan_app.png'),
          ],
        ),
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


  
  //launch Navara
  Future<void> launchNavara() async {
    final theme = Theme.of(context);
    try{
      await launch('http://119.2.50.170:9094/navara/',
       customTabsOption: CustomTabsOption(
         toolbarColor: white,
         enableDefaultShare: true,
         enableUrlBarHiding: true,
         showPageTitle: true,
         animation: CustomTabsSystemAnimation.slideIn(),
         extraCustomTabs: const<String>[
           // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
           'org.mozilla.firefox',
           // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
           'com.microsoft.emmx',
         ]
       )
      );
    } catch(e){
      debugPrint(e.toString());
    }
  }
  
  //launch whatsapp kepegawaian
  Future<void> whatsAppKepegawaian() async{
    await launch('https://wa.me/62895640500605');
  }


  //launch whatsapp kepegawaian
  Future<void> whatsAppAmbulance() async{
    await launch('https://wa.me/6282139753077');
  }

  //launch SIMPATIK
  Future<void> launchSIMPATIK() async{
    await launch('https://simpatik.semarangkota.go.id/login');
  }

  //launch dinkesapp
  Future<void> launchDinkesApp() async{
    await launch('https://dinkes.semarangkota.go.id/aplikasi/');
  }

}

import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/page/login_screen.dart';

import '../theme/theme.dart';
import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _sessionManager = SessionManager();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), (){
      checkLoginSession();
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlueBlack,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/image/dkk_gedung.png', fit: BoxFit.fitWidth, alignment: Alignment.bottomLeft)),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 172, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MyDarling', style: title.copyWith(color: Colors.white, fontSize: 36)),
                const SizedBox(height: 16),
                Text('Aplikasi Manajemen Layanan Terpadu Kinerja\nPegawai Dinas Kesehatan Kota Semarang', style: regular.copyWith(color: Colors.white, fontWeight: FontWeight.w300, height: 1.4), textAlign: TextAlign.start),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child:Text('©Dinas Kesehatan Kota Semarang 2023', style: regular.copyWith(color: Colors.white, fontSize: 13)),),
          ),
        ],
      ),
    );
  }

  Future<bool> checkLoginSession() async{
    var checkLogin = await _sessionManager.isLogin();
    if(checkLogin!=null && checkLogin == true){
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
              const HomeScreen()),
              (Route<dynamic> route) => false);
      return checkLogin;
    }
    else{
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
              const LoginScreen()),
              (Route<dynamic> route) => false);
    }
    return false;
  }
}


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_darling_app/const.dart';
import 'package:my_darling_app/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.robotoSlabTextTheme(Theme.of(context).textTheme),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: redColor
        )
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const LoginScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(child: Image.asset('assets/images/gedungdkk.png', fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter,)),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 172, left: 32, right: 32),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height:84),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MyDarling", style: headingTextStyle.copyWith(color: whiteColor)),
                      const SizedBox(height:16),
                      Text("Manajemen Layanan Terpadu Kinerja\nPegawai Dinas Kesehatan Kota Semarang ", style: bodyTextStyle.copyWith(color: whiteColor)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 56,
              child: Text("©Dinas kesehatan Kota Semarang 2022", style: bodyTextStyle.copyWith(color: whiteColor, fontWeight: FontWeight.w700))
            )
      ],
        )


    );
  }
}




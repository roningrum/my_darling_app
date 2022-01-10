import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_darling_app/const.dart';

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
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: const MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width,height: 172),
          Text('MyDarling', style: headingTextStyle.copyWith(color: Colors.white)),
          Text('Manajemen Layanan Terpadu Kinerja\nPegawai Dinas Kesehatan Kota Semarang', style: subtitleTextStyle.copyWith(color: Colors.white)),
          Image.asset('assets/images/gedungdkk.png')
        ],
      )
    );
  }
}


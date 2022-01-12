import 'package:flutter/material.dart';

import 'const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/gedungdkk.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: primaryColor.withOpacity(0.2),
              margin: const EdgeInsets.only(top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text("MyDarling",
                          style: headingTextStyle.copyWith(color: whiteColor))),
                  Container(
                    margin: const EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 84),
                        Text("Selamat Datang",
                            style: headingTextStyle.copyWith(color: whiteColor),
                            textAlign: TextAlign.start),
                        const SizedBox(height: 64),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 48,
                              height: 56,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: greyColor,
                                  labelText: 'Nomor Induk Pegawai',
                                  labelStyle: subtitleTextStyle.copyWith(
                                      color: secondaryColor),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 2.0)),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                        color: greyColor, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 48,
                              height: 56,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: greyColor,
                                  labelText: 'Kata Sandi',
                                  labelStyle: subtitleTextStyle.copyWith(
                                      color: secondaryColor),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                          color: secondaryColor, width: 2.0)),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                        color: greyColor, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: 245,
                              height: 56,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Masuk',
                                      style: bodyTextStyle.copyWith(
                                          fontSize: 14, color: whiteColor)),
                                  style: ElevatedButton.styleFrom(
                                    primary: redColor,
                                    padding: const EdgeInsets.all(8.0),
                                    textStyle: bodyTextStyle,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/network_provider/NetworkRepository.dart';

import '../theme/theme.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _networkRepo = NetworkRepository();
  final _sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlueBlack,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/image/dkk_gedung.png',
                  fit: BoxFit.fitWidth, alignment: Alignment.bottomLeft)),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 72, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('MyDarling',
                    style: title.copyWith(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 16),
                Text(
                    'Aplikasi Manajemen Layanan Terpadu Kinerja\nPegawai Dinas Kesehatan Kota Semarang',
                    style: regular.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        height: 1.4),
                    textAlign: TextAlign.center),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'email is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'email',
                      labelStyle: regular.copyWith(color: secondaryBlueBlack),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(color: secondaryBlueBlack, width: 2.0)),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(color: greyColor, width: 2.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'password is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    labelStyle: regular.copyWith(color: secondaryBlueBlack),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                        borderSide:
                        BorderSide(color: secondaryBlueBlack, width: 2.0)),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: greyColor, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 250,
                  height: 56,
                  child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          String email = emailController.text;
                          String password = passwordController.text;
                          doLogin(email, password);
                          // _networkRepo.doLogin(email, password);
                          print('Email : $email Password : $password');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        padding: const EdgeInsets.all(8.0),
                        textStyle: regular,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Masuk', style: regular.copyWith(fontSize: 14, color: white))),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Text('©Dinas Kesehatan Kota Semarang 2023',
                  style: regular.copyWith(color: Colors.white, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  void doLogin(String email, String password) async {
    var response = await _networkRepo.doLogin(email, password);
    setState(() {
      if(response.status == "sukses"){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomeScreen()));
        _sessionManager.saveUserToken('token', response.accessToken!);
        _sessionManager.saveNama('nama', response.user!.nama!);
        Fluttertoast.showToast(msg: response.pesan!, toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
        Fluttertoast.showToast(msg: "Silakan Cek Username dan password", toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    });
  }
}

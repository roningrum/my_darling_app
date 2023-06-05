import 'package:flutter/material.dart';
import 'package:my_darling_app/helper/session_manager.dart';
import 'package:my_darling_app/repository/network_repo.dart';

import '../theme/theme.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _networkRepo = NetworkRepo();
  final _sessionManager = SessionManager();

  bool _isloading = false;

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
                    controller: usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'username is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'username',
                      labelStyle: regular.copyWith(color: secondaryBlueBlack),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                              color: secondaryBlueBlack, width: 2.0)),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
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
                  validator: (value) {
                    if (value!.isEmpty) {
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: greyColor, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                !_isloading
                    ? SizedBox(
                        width: 250,
                        height: 56,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                String username = usernameController.text;
                                String password = passwordController.text;
                                doLogin(username, password, context);
                                // _networkRepo.doLogin(email, password);
                                print(
                                    'username : $username Password : $password');
                                setState(() => _isloading = true);
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
                            child: Text('Masuk',
                                style: regular.copyWith(
                                    fontSize: 14, color: white))),
                      )
                    : CircularProgressIndicator(color: primaryRed)
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

  void doLogin(String username, String password, BuildContext context) async {
    var response = await _networkRepo.getLogin(username, password);
    if (response.isNotEmpty) {
      _sessionManager.saveUserToken('token', response[0].token!);
      _sessionManager.saveIdUser('userId', response[0].userId!);
      _sessionManager.saveNikUser('nik', response[0].nik!);
      _sessionManager.setBidang('bidang', response[0].bidang!);
      _sessionManager.setSeksi('seksi', response[0].seksi!);
      _sessionManager.setRule('rule', response[0].rule!);
      // if (mounted) return;
      Navigator.pop(context);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(
                nama: response[0].nama!,
              )));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

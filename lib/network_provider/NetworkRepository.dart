import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_darling_app/Login_response.dart';

class NetworkRepository{

  // Login
  Future<LoginResponse>doLogin(String email, String password) async{
    var url = 'http://172.17.19.168/mydarling_web/public/api/login';
    var response = await http.post(Uri.parse(url), body: {'email':email, 'password': password});
    // print(response.body);
    var jsonResponse = jsonDecode(response.body);
    LoginResponse responseLogin = LoginResponse.fromJson(jsonResponse);
    if (kDebugMode) {
      print('response:$responseLogin');
    }
    return responseLogin;
  }
}
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_darling_app/model/login_response.dart';
import 'package:my_darling_app/model/logout_response.dart';
import 'package:my_darling_app/model/record_jalan_response.dart';

class NetworkRepository{

  // Login
  Future<LoginResponse>doLogin(String email, String password) async{
    var url = 'http://172.17.19.179:8000/api/login';
    var response = await http.post(Uri.parse(url), body: {'email':email, 'password': password});
    // print(response.body);
    var jsonResponse = jsonDecode(response.body);
    LoginResponse responseLogin = LoginResponse.fromJson(jsonResponse);
    if (kDebugMode) {
      print('response:${response.body}');
    }
    return responseLogin;
  }

  //Send Data Walking

  Future<RecordJalanResponse> sendWalkRecord(String nik, String langkah, String token) async{
    var url = 'http://172.17.19.179:8000/api/submit-jalan';
    final msg = jsonEncode({'nik': nik, 'langkah_terekam': langkah});
    var response = await http.post(Uri.parse(url), headers:{'Authorization':'Bearer $token', 'Content-Type': 'application/json'}, body: msg );
    var jsonResponse = jsonDecode(response.body);
    if(response.statusCode == 200){
      print('response:${jsonResponse}');
    }
    else{
      print('response: not found');
    }
    RecordJalanResponse recordResponse = RecordJalanResponse.fromJson(jsonResponse);
    return recordResponse;
  }


  //logout
  Future<LogoutResponse>doLogout(String token) async{
    var url = 'http://172.17.19.179:8000/api/logout';
    var response = await http.post(Uri.parse(url),headers:{'Authorization':'Bearer $token'});
    var jsonResponse = jsonDecode(response.body);
    LogoutResponse responseLogout = LogoutResponse.fromJson(jsonResponse);
    if(kDebugMode){
      print('response: ${response.body}');
    }
    return responseLogout;

  }
}
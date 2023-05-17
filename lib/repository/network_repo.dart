import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:my_darling_app/repository/bidang_response.dart';
import 'package:my_darling_app/repository/login_response.dart';
import 'package:my_darling_app/repository/user_response.dart';

class NetworkRepo{
  final String url_dispo = 'http://119.2.50.170:9095/e_dispo/index.php/service';

  //getLogin
  Future<List<Login>> getLogin(String username, String password) async{
    final queryParameters={'username': username, 'password': password};
    var response = await http.get(Uri.parse('$url_dispo/login').replace(queryParameters: queryParameters));
    List<Login> loginUserList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic> data =jsonData['login'];
      loginUserList = data.map((data) => Login.fromJson(data)).toList();
      return loginUserList;
    }
    else{
      throw response.statusCode;
    }
  }

  //get Detail User
  Future<List<User>> getUserProfile(String userId)async{
    final queryParameters={'user_id': userId};
    var response = await http.get(Uri.parse('$url_dispo/get_detail_userbyid').replace(queryParameters: queryParameters));
    List<User> userDetailList =[];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['user'];
      userDetailList = data.map((data) => User.fromJson(data)).toList();
      return userDetailList;
    }
    else{
      throw response.statusCode;
    }
  }


  //get Bidang
  Future<List<Bidang>> getBidang() async{
    var response = await http.get(Uri.parse('$url_dispo/get_bidang'));
    List<Bidang> bidangList = [];
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      List<dynamic> data =jsonData['bidang'];
      bidangList = data.map((data) => Bidang.fromJson(data)).toList();
      return bidangList;
    }
    else{
      throw response.statusCode;
    }

  }
}
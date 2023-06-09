import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:my_darling_app/repository/model/agenda_surat_response.dart';
import 'package:my_darling_app/repository/model/catatan_kesehatan_response.dart';
import 'package:my_darling_app/repository/model/record_langkah.dart';
import 'package:my_darling_app/repository/model/token_response.dart';
import 'package:my_darling_app/repository/model/user_response.dart';

import 'model/Kegiatan_pppk_response.dart';
import 'model/bidang_response.dart';
import 'model/kegiatan_internal_response.dart';
import 'model/kegiatan_luar_response.dart';
import 'model/login_response.dart';
import 'model/surat_response.dart';

class NetworkRepo{
  final String url_dispo = 'http://119.2.50.170:9095/e_dispo/index.php/service';
  final String url_record = 'http://119.2.50.170:9094/mydarling/api';
  final String url_yohSehat = 'http://119.2.50.170:7773/db_ lb1/api';

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
  Future<List<User>> getUserProfile(String? userId)async{
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

  //get Surat Proses
  Future<List<Surat>> getSuratProses(String jenis, String rule, String bidang, String seksi, String userId) async{
    final queryParameters = {'jenis':jenis, 'rule':rule, 'bidang':bidang, 'seksi':seksi, 'user_id':userId, 'status1': 'disposisi', 'status2':'diterima'};
    var response = await http.get(Uri.parse('$url_dispo/surat_dp').replace(queryParameters: queryParameters));
    if(kDebugMode){
      print('response url ${response.request}');
      print('Data Response ${response.body}');
    }
    List<Surat> suratDPList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic>data = jsonData['surat'];
      suratDPList = data.map((data) => Surat.fromJson(data)).toList();
      return suratDPList;
    }
    else{
      throw response.statusCode;
    }
  }

  //get Surat Proses
  Future<List<Surat>> getSuratProsesKadin(String jenis) async{
    final queryParameters = {'jenis':jenis};
    var response = await http.get(Uri.parse('$url_dispo/get_surat_dp_kadin_sudah_diproses').replace(queryParameters: queryParameters));
    if(kDebugMode){
      print('response url ${response.request}');
      print('Data Response ${response.body}');
    }
    List<Surat> suratDPList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic>data = jsonData['surat'];
      suratDPList = data.map((data) => Surat.fromJson(data)).toList();
      return suratDPList;
    }
    else{
      throw response.statusCode;
    }
  }

  //get Surat belum diproses
  Future<List<Surat>> getSuratBelumProses(String jenis, String rule, String bidang, String seksi, String userId) async{
    final queryParameters = {'jenis':jenis, 'rule':rule, 'bidang':bidang, 'seksi':seksi, 'user_id':userId, 'status1': 'proses', 'status2':'proses'};
    var response = await http.get(Uri.parse('$url_dispo/surat_dp').replace(queryParameters: queryParameters));
    if(kDebugMode){
      print('response url ${response.request}');
      print('Data Response ${response.body}');
    }
    List<Surat> suratDPList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic>data = jsonData['surat'];
      suratDPList = data.map((data) => Surat.fromJson(data)).toList();
      return suratDPList;
    }
    else{
      throw response.statusCode;
    }
  }
  //get Agenda
  Future<List<Data>> getAgenda(String dari, String sampai) async{
    final queryParameters={'dari': dari, 'sampai': sampai};
    var response = await http.get(Uri.parse('$url_dispo/agenda').replace(queryParameters: queryParameters));
    List<Data> agendaList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic>data = jsonData['result']['data'];
      agendaList = data.map((data) => Data.fromJson(data)).toList();
      return agendaList;
    }
    else{
      throw response.statusCode;
    }
  }

  //post Record Langkah
  Future<RecordLangkah> sendRecordLangkah(String nik, String langkah)async{
    var requestBody = {
      'nik': nik,
      'langkah': langkah
    };
    var response = await http.post(Uri.parse('$url_record/create_record_langkah'), body: requestBody);
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      var data = RecordLangkah.fromJson(jsonData);
      RecordLangkah recordResponse = data;
      if (kDebugMode) {
        print('Response $recordResponse');
      }
      return recordResponse;
    }
    else{
      throw response.statusCode;
    }
  }

  //login Yoh Sehat
  Future<String?> getToken()async{
    final requestBody = {
      'name':'yohsehat',
      'email': 'yohsehat@gmail.com',
      'password':'yohsehat'
    };
    final responseYohSehat = await http.post(Uri.parse('$url_yohSehat/login'), body: requestBody);
    if(responseYohSehat.statusCode == 200){
      var tokenResponse = jsonDecode(responseYohSehat.body);
      final token = TokenResponse.fromJson(tokenResponse).accessToken;
      return token;
    }
    else{
      return throw responseYohSehat.statusCode;
    }
  }

  Future<List<CatatanKesehatanResponse>> getCatatanKesehatan(String? nik) async{
    final token = await getToken();
    final response = await http.post(Uri.parse('$url_yohSehat/catatan_kesehatan'), body: {'nik': nik}, headers: {'Authorization':'Bearer $token'});
    if (kDebugMode) {
      print("Data: ${response.body}");
    }

    if(response.statusCode == 200){
      List<dynamic>catatanResponse = jsonDecode(response.body);
      List<CatatanKesehatanResponse> recordKesehatan = [];
      recordKesehatan = catatanResponse.map((catatanResponse) => CatatanKesehatanResponse.fromJson(catatanResponse)).toList();
      return recordKesehatan;
    }
    else{
      return throw response.statusCode;
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

  //get kegiatan Internal bidang
  Future<List<KegiatanInternal>> getKegiatanInternal(String idBidang, String tglKegiatan) async{
    final queryparameter = {"id_bidang":idBidang,"tgl_kegiatan":tglKegiatan};
    var response = await http.get(Uri.parse('$url_dispo/get_kegiatan_internal_bybidang').replace(queryParameters: queryparameter));
    List<KegiatanInternal> kegiatanList =[];
    if(response.statusCode == 200){
       var jsonData = json.decode(response.body);
       List<dynamic> data = jsonData['kegiatan_internal'];
       kegiatanList = data.map((data) => KegiatanInternal.fromJson(data)).toList();
       if (kDebugMode) {
         print("Data: $data");
       }
       return kegiatanList;
    }
    else{
      throw response.statusCode;
    }
  }

  //get kegiatan eksternal Bidang
  Future<List<KegiatanLuar>> getKegiatanExternal(String idBidang, String tglKegiatan) async{
    final queryparameter = {"id_bidang":idBidang,"tgl_kegiatan":tglKegiatan};
    var response = await http.get(Uri.parse('$url_dispo/get_kegiatan_luar_bybidang').replace(queryParameters: queryparameter));
    if (kDebugMode) {
      print("Data Kegiatan: ${response.body}");
    }
    List<KegiatanLuar> kegiatanList =[];
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData['kegiatan_luar'];
      kegiatanList = data.map((data) => KegiatanLuar.fromJson(data)).toList();
      return kegiatanList;
    }
    else{
      throw response.statusCode;
    }
  }

  //get kegiatan PPPK
  Future<List<KegiatanPppk>> getKegiatanPPPK(String dari, String sampai) async{
    final queryParameter ={"dari":dari, "sampai":sampai};
    var response = await http.get(Uri.parse('$url_dispo/get_pppk').replace(queryParameters: queryParameter));
    if(kDebugMode){
      print("Data Kegiatan PPPK : ${response.body}");
    }
    List<KegiatanPppk> kegiatanList = [];
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData['kegiatan_pppk'];
      kegiatanList = data.map((data) => KegiatanPppk.fromJson(data)).toList();
      return kegiatanList;
    }
    else{
      throw response.statusCode;
    }


  }
}
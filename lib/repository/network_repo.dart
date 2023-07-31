import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_darling_app/repository/model/Dinkes_news_response.dart';
import 'package:my_darling_app/repository/model/Item_notulen_response.dart';
import 'package:my_darling_app/repository/model/Walking_data_response.dart';
import 'package:my_darling_app/repository/model/agenda_surat_response.dart';
import 'package:my_darling_app/repository/model/catatan_kesehatan_response.dart';
import 'package:my_darling_app/repository/model/data_checkup_response.dart';
import 'package:my_darling_app/repository/model/send_record_langkah.dart';
import 'package:my_darling_app/repository/model/token_response.dart';
import 'package:my_darling_app/repository/model/user_response.dart';

import 'model/Kegiatan_pppk_response.dart';
import 'model/bidang_response.dart';
import 'model/kegiatan_internal_response.dart';
import 'model/kegiatan_luar_response.dart';
import 'model/login_response.dart';
import 'model/record_langkah.dart';
import 'model/surat_response.dart';

class NetworkRepo {
  final String urlDispo = 'http://119.2.50.170:9095/e_dispo/index.php/service';
  final String urlAKM = 'http://119.2.50.170:9095/akm/service';
  final String urlRecord = 'http://119.2.50.170:9094/mydarling/api';
  final String urlYohSehat ='http://119.2.50.170:7773/db_lb1/api';
  final String urlDinkesNews ='https://dinkes.semarangkota.go.id/content/ajax/info_semarang';

  //getLogin
  Future<List<Login>> getLogin(String username, String password) async {
    final queryParameters = {'username': username, 'password': password};
    var response = await http.get(Uri.parse('$urlDispo/login')
        .replace(queryParameters: queryParameters));
    List<Login> loginUserList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['login'];
      loginUserList = data.map((data) => Login.fromJson(data)).toList();
      return loginUserList;
    } else {
      throw response.statusCode;
    }
  }

  //get Detail User
  Future<List<User>> getUserProfile(String? userId) async {
    final queryParameters = {'user_id': userId};
    var response = await http.get(Uri.parse('$urlDispo/get_detail_userbyid')
        .replace(queryParameters: queryParameters));
    List<User> userDetailList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['user'];
      userDetailList = data.map((data) => User.fromJson(data)).toList();
      return userDetailList;
    } else {
      throw response.statusCode;
    }
  }

  //get Surat Proses
  Future<List<Surat>> getSuratProses(String jenis, String rule, String bidang,
      String seksi, String userId) async {
    final queryParameters = {
      'jenis': jenis,
      'rule': rule,
      'bidang': bidang,
      'seksi': seksi,
      'user_id': userId,
      'status1': 'disposisi',
      'status2': 'diterima'
    };
    var response = await http.get(Uri.parse('$urlDispo/surat_dp')
        .replace(queryParameters: queryParameters));
    if (kDebugMode) {
      print('response url ${response.request}');
      print('Data Response ${response.body}');
    }
    List<Surat> suratDPList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['surat'];
      suratDPList = data.map((data) => Surat.fromJson(data)).toList();
      return suratDPList;
    } else {
      throw response.statusCode;
    }
  }

  //get Surat Proses
  Future<List<Surat>> getSuratProsesKadin(String jenis) async {
    final queryParameters = {'jenis': jenis};
    var response = await http.get(
        Uri.parse('$urlDispo/get_surat_dp_kadin_sudah_diproses')
            .replace(queryParameters: queryParameters));
    if (kDebugMode) {
      print('response url ${response.request}');
      print('Data Response ${response.body}');
    }
    List<Surat> suratDPList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['surat'];
      suratDPList = data.map((data) => Surat.fromJson(data)).toList();
      return suratDPList;
    } else {
      throw response.statusCode;
    }
  }

  //get Surat DP berdasarkan Tanggal
  Future<List<Surat>> getSuratProsesByTgl(String jenis, String rule,
      String bidang, String seksi, String userId, String tgl) async {
    final queryParameters = {
      'jenis': jenis,
      'rule': rule,
      'bidang': bidang,
      'seksi': seksi,
      'user_id': userId,
      'status1': 'disposisi',
      'status2': 'diterima',
      'tgl_agenda': tgl
    };
    var response = await http.get(Uri.parse('$urlDispo/surat_dp_by_tgl')
        .replace(queryParameters: queryParameters));
    if (kDebugMode) {
      print('response url ${response.request}');
      print('Data Response ${response.body}');
    }
    List<Surat> suratDPList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['surat'];
      suratDPList = data.map((data) => Surat.fromJson(data)).toList();
      return suratDPList;
    } else {
      throw response.statusCode;
    }
  }

  //get Surat belum diproses
  Future<List<Surat>> getSuratBelumProses(String jenis, String rule,
      String bidang, String seksi, String userId) async {
    final queryParameters = {
      'jenis': jenis,
      'rule': rule,
      'bidang': bidang,
      'seksi': seksi,
      'user_id': userId,
      'status1': 'proses',
      'status2': 'proses'
    };
    var response = await http.get(Uri.parse('$urlDispo/surat_dp')
        .replace(queryParameters: queryParameters));
    if (kDebugMode) {
      print('response url ${response.request}');
      print('Data Response ${response.body}');
    }
    List<Surat> suratDPList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['surat'];
      suratDPList = data.map((data) => Surat.fromJson(data)).toList();
      return suratDPList;
    } else {
      throw response.statusCode;
    }
  }

  Future<List<Surat>> getSuratBelumProsesByTgl(String jenis, String rule,
      String bidang, String seksi, String userId, String tgl) async {
    final queryParameters = {
      'jenis': jenis,
      'rule': rule,
      'bidang': bidang,
      'seksi': seksi,
      'user_id': userId,
      'status1': 'proses',
      'status2': 'proses',
      'tgl_agenda': tgl
    };
    var response = await http.get(Uri.parse('$urlDispo/surat_dp_by_tgl')
        .replace(queryParameters: queryParameters));
    if (kDebugMode) {
      print('response url ${response.request}');
      print('Data Response ${response.body}');
    }
    List<Surat> suratDPList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['surat'];
      suratDPList = data.map((data) => Surat.fromJson(data)).toList();
      return suratDPList;
    } else {
      throw response.statusCode;
    }
  }

  //get Agenda
  Future<List<Data>> getAgenda(String dari, String sampai) async {
    final queryParameters = {'dari': dari, 'sampai': sampai};
    var response = await http.get(Uri.parse('$urlDispo/agenda')
        .replace(queryParameters: queryParameters));
    List<Data> agendaList = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['result']['data'];
      agendaList = data.map((data) => Data.fromJson(data)).toList();
      return agendaList;
    } else {
      throw response.statusCode;
    }
  }

  //post Record Langkah
  Future<SendRecordLangkah?>sendRecordLangkah(String nik, String langkah, String cal) async {
    try{
      http.Response response = await http.post(Uri.parse('http://119.2.50.170:9094/mydarling/api/create_record_langkah'),
      body: {
        "nik": nik,
        "langkah": langkah,
        "cal":cal
      });
      if(response.statusCode == 200){
        if (kDebugMode) {
          print("Response URL ${response.request}");
          var jsonData = json.decode(response.body);
          var data = SendRecordLangkah.fromJson(jsonData);
          SendRecordLangkah recordResponse = data;
          if (kDebugMode) {
            print('Response ${recordResponse.langkah}');
          }
          return recordResponse;
        }
      }
      else{
        print("Response error: ${response.body}");
      }
    }
    catch(e){
      print("Response error: ${e.toString()}");
    }
    return null;
  }

  //getSemua Langkah
  Future<List<RecordLangkah>>getAllRecordDaily(String nik) async {
    try{
      http.Response response = await http.post(Uri.parse('http://119.2.50.170:9094/mydarling/api/semua_record_langkah').replace(queryParameters: {'nik':nik}));
      if(response.statusCode == 200){
        if (kDebugMode) {
          print("Response URL ${response.request}");
          var jsonData = json.decode(response.body);
          List<RecordLangkah> recordList = [];
          List<dynamic> recordData = jsonData;

          recordList = recordData.map((data) => RecordLangkah.fromJson(data)).toList();
          if (kDebugMode) {
            print('Response $recordList');
          }
          return recordList;
        }
      }
      else{
        if (kDebugMode) {
          print("Response error: ${response.body}");
        }
      }
    }
    catch(e){
      if (kDebugMode) {
        print("Response error: ${e.toString()}");
      }
    }
    return [];
  }

  //login Yoh Sehat
  Future<String?> getToken() async {
    final requestBody = {
      'name': 'yohsehat',
      'email': 'yohsehat@gmail.com',
      'password': 'yohsehat'
    };
    final responseYohSehat = await http.post(Uri.parse('$urlYohSehat/login'), body: requestBody);
    if (responseYohSehat.statusCode == 200) {
      var tokenResponse = jsonDecode(responseYohSehat.body);
      final token = TokenResponse.fromJson(tokenResponse).accessToken;
      return token;
    } else {
      return throw responseYohSehat.statusCode;
    }
  }

  Future<List<CatatanKesehatanResponse>> getCatatanKesehatan(
      String? nik) async {
    final token = await getToken();
    final response = await http.post(
        Uri.parse('$urlYohSehat/catatan_kesehatan'),
        body: {'nik': nik},
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      List<dynamic> catatanResponse = jsonDecode(response.body);
      List<CatatanKesehatanResponse> recordKesehatan = [];
      recordKesehatan = catatanResponse
          .map((catatanResponse) =>
              CatatanKesehatanResponse.fromJson(catatanResponse))
          .toList();
      if (kDebugMode) {
        print("Data: $recordKesehatan");
      }
      return recordKesehatan;
    } else {
      return throw response.statusCode;
    }
  }

  //get Bidang
  Future<List<Bidang>> getBidang() async {
    var response = await http.get(Uri.parse('$urlDispo/get_bidang'));
    List<Bidang> bidangList = [];
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData['bidang'];
      bidangList = data.map((data) => Bidang.fromJson(data)).toList();
      return bidangList;
    } else {
      throw response.statusCode;
    }
  }

  //get kegiatan Internal bidang
  Future<List<KegiatanInternal>> getKegiatanInternal(
      String idBidang, String tglKegiatan) async {
    final queryparameter = {"id_bidang": idBidang, "tgl_kegiatan": tglKegiatan};
    var response = await http.get(
        Uri.parse('$urlDispo/get_kegiatan_internal_bybidang')
            .replace(queryParameters: queryparameter));
    List<KegiatanInternal> kegiatanList = [];
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData['kegiatan_internal'];
      kegiatanList =
          data.map((data) => KegiatanInternal.fromJson(data)).toList();
      if (kDebugMode) {
        print("Data: $data");
      }
      return kegiatanList;
    } else {
      throw response.statusCode;
    }
  }

  //get kegiatan eksternal Bidang
  Future<List<KegiatanLuar>> getKegiatanExternal(
      String idBidang, String tglKegiatan) async {
    final queryparameter = {"id_bidang": idBidang, "tgl_kegiatan": tglKegiatan};
    var response = await http.get(
        Uri.parse('$urlDispo/get_kegiatan_luar_bybidang')
            .replace(queryParameters: queryparameter));
    if (kDebugMode) {
      print("Data Kegiatan: ${response.body}");
    }
    List<KegiatanLuar> kegiatanList = [];
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData['kegiatan_luar'];
      kegiatanList = data.map((data) => KegiatanLuar.fromJson(data)).toList();
      return kegiatanList;
    } else {
      throw response.statusCode;
    }
  }

  //get kegiatan PPPK
  Future<List<KegiatanPppk>> getKegiatanPPPK(String dari, String sampai) async {
    final queryParameter = {"dari": dari, "sampai": sampai};
    var response = await http.get(Uri.parse('$urlDispo/get_pppk')
        .replace(queryParameters: queryParameter));
    if (kDebugMode) {
      print("Data Kegiatan PPPK : ${response.body}");
    }
    List<KegiatanPppk> kegiatanList = [];
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData['kegiatan_pppk'];
      kegiatanList = data.map((data) => KegiatanPppk.fromJson(data)).toList();
      return kegiatanList;
    } else {
      throw response.statusCode;
    }
  }

  //get semua langkah jalan based on nik
  Future<List<WalkingDataResponse>> getRiwayatJalan(String nik) async {
    var response = await http.post(
        Uri.parse('$urlRecord/semua_record_langkah'),
        body: {'nik': nik});
    List<WalkingDataResponse> walkinList = [];
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> list = jsonData;
      walkinList =
          list.map((data) => WalkingDataResponse.fromJson(data)).toList();
      return walkinList;
    } else {
      throw response.statusCode;
    }
  }

  //get semua notulen
  Future<List<ItemNotulen>> getNotulen(String userId) async {
    var response = await http.get(Uri.parse('$urlDispo/notulen')
        .replace(queryParameters: {"user_id": userId}));
    List<ItemNotulen> notulenList = [];
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> list = jsonData["item_notulen"];
      notulenList = list.map((data) => ItemNotulen.fromJson(data)).toList();
      return notulenList;
    } else {
      throw response.statusCode;
    }
  }

  /*
  * AKM
  * */
  //checkup
  Future<List<DataCheckup>> getDataCheckupTerakhir(String nik) async{
    var response = await http.get(Uri.parse('$urlAKM/show_data_checkup_sekarang_user').replace(queryParameters: {"nik":nik}));
    List<DataCheckup> dataCheckupList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic> list = jsonData["data_checkup"];
      dataCheckupList = list.map((data) => DataCheckup.fromJson(data)).toList();
      return dataCheckupList;
    }
    else{
      throw response.statusCode;
    }
  }
  Future<List<DataCheckup>> getBeratBadanTerakhir(String nik) async{
    var response = await http.get(Uri.parse('$urlAKM/show_history_user_berat_badan').replace(queryParameters: {"nik":nik}));
    List<DataCheckup> dataCheckupList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic> list = jsonData["data_checkup"];
      dataCheckupList = list.map((data) => DataCheckup.fromJson(data)).toList();
      return dataCheckupList;
    }
    else{
      throw response.statusCode;
    }
  }

  Future<List<DataCheckup>> getTinggiBadanTerakhir(String nik) async{
    var response = await http.get(Uri.parse('$urlAKM/show_history_user_tinggi_badan').replace(queryParameters: {"nik":nik}));
    List<DataCheckup> dataCheckupList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic> list = jsonData["data_checkup"];
      dataCheckupList = list.map((data) => DataCheckup.fromJson(data)).toList();
      return dataCheckupList;
    }
    else{
      throw response.statusCode;
    }
  }
  Future<List<DataCheckup>> getHistoryTensiTerakhir(String nik) async{
    var response = await http.get(Uri.parse('$urlAKM/show_history_user_tensi').replace(queryParameters: {"nik":nik}));
    List<DataCheckup> dataCheckupList = [];
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      List<dynamic> list = jsonData["data_checkup"];
      dataCheckupList = list.map((data) => DataCheckup.fromJson(data)).toList();
      return dataCheckupList;
    }
    else{
      throw response.statusCode;
    }
  }

  //get Berita Dinkes
  Future<List<DinkesNewsResponse>>getListNews()async{
    var response = await http.get(Uri.parse(urlDinkesNews));
    List<DinkesNewsResponse> news = [];
    if(response.statusCode == 200){
      Iterable jsonData = jsonDecode(response.body);
      news = jsonData.map((data)=> DinkesNewsResponse.fromJson(data)).toList();
      return news;
    }
    else{
      return throw response.statusCode;
    }
  }
}

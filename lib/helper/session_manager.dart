import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{


  Future<void>createLoginStatus() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("login_status", true);
  }

  Future<void> saveUserToken(String key, String authToken) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, authToken);
  }

  Future<void>saveNikUser(String key, String nik) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, nik);
  }

  Future<void>saveIdUser(String key, String userId) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, userId);
  }

  Future<void> setBidang(String key, String bidang) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, bidang);
  }

  Future<void> setSeksi(String key, String seksi) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, seksi);
  }

  Future<void>setRule(String key, String rule) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, rule);
  }

  // save state swi


  Future<String?>getUserId(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<String?>getNikUser(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<String?>getBidang(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<String?>getSeksi(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<String?>getRule(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveNama(String key, String nama) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, nama);
  }

  Future<String?> readNama(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<String?>readToken(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  
  Future<bool?>isLogin() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("login_status");
  }

  //Hapus Semua Shared Pref
  Future<void>clear() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}
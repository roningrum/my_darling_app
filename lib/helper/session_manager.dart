import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{

  Future<void> saveUserToken(String key, String authToken) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, authToken);
  }

  Future<String?> readToken(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void>saveNikUser(String key, String nik) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, nik);
  }

  Future<void>saveIdUser(String key, String userId) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, userId);
  }

  Future<String?>getUserId(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<String?>getNikUser(String key) async{
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
}
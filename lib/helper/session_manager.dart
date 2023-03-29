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

  Future<void>saveNikUser(String key, int nik) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, nik);
  }

  Future<int?>getNikUser(String key) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
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
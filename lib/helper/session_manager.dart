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
}
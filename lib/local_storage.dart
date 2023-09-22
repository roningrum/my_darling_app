import 'dart:convert';

import 'package:my_darling_app/local/storage_data.dart';
import 'package:my_darling_app/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage<T> implements StorageProvider<T>{
  @override
  Future<bool> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  @override
  Future<bool> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }

  @override
  Future<T?> read(String key) async{
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if(jsonString == null || jsonString.isEmpty){
      return null;
    }
    try{
      final jsonObject = json.decode(jsonString) as Map<String, dynamic>;
      final storage = StorageData<T>.fromJson(jsonObject);
      return storage.data;
    } catch(e){
      return null;
    }
  }

  @override
  Future<bool> write(String key, T data) async {
    try {
      final jsonString = json.encode(StorageData<T>(data: data));
      final prefs = await SharedPreferences.getInstance();

      return await prefs.setString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

}
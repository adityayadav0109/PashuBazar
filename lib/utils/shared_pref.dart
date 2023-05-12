import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<bool> saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }


  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> saveStringList(String key, List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  static Future<List<String>?> getStringList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  static Future<bool> addObjectToList(String key, dynamic value) async {
    List<dynamic> list = await getObjectList(key) ?? [];
    list.add(value.toJson());
    return saveStringList(key, list.map((item) => jsonEncode(item)).toList());
  }

  static Future<List<dynamic>?> getObjectList(String key) async {
    List<String>? jsonStringList = await getStringList(key);
    return jsonStringList?.map((item) => jsonDecode(item)).toList();
  }

  static Future<List<T>> getListOfObjects<T>(String key, T Function(Map<String, dynamic>) fromJson) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList(key) ?? [];

    return jsonStringList.map((jsonString) => fromJson(jsonDecode(jsonString))).toList();
  }

}

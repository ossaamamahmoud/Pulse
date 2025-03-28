import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setBoolData(
      {required String key, required bool value}) async {
    return await _sharedPreferences.setBool(key, value);
  }

  static bool? getBoolData({required String key}) {
    return _sharedPreferences.getBool(key);
  }

  static Future<bool?> setStringData(
      {required String key, required String value}) async {
    return await _sharedPreferences.setString(key, value);
  }

  static String? getStringData({required String key}) {
    return _sharedPreferences.getString(key);
  }

  static Future<bool?> setIntData(
      {required String key, required int value}) async {
    return await _sharedPreferences.setInt(key, value);
  }

  static int? getIntData({required String key}) {
    return _sharedPreferences.getInt(key);
  }

  static Future<bool?> setDoubleData(
      {required String key, required double value}) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  static double? getDoubleData({required String key}) {
    return _sharedPreferences.getDouble(key);
  }

  static Future<bool?> setStringListData(
      {required String key, required List<String> value}) async {
    return await _sharedPreferences.setStringList(key, value);
  }

  static List<String>? getStringListData({required String key}) {
    return _sharedPreferences.getStringList(key);
  }

  static Future<bool?> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool?> clearData() async {
    return await _sharedPreferences.clear();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

enum DbEnum { user, results }

class DbService {
  static late final SharedPreferences _instance;

  static Future<void> initSharedPref() async {
    _instance = await SharedPreferences.getInstance();
  }

  /// String list
  static Future<bool> setLocalStringList(DbEnum key, List<String> data) async {
    return await _instance.setStringList(key.name, data);
  }

  static List<String>? getLocalStringList(DbEnum key) {
    return _instance.getStringList(key.name);
  }

  /// String
  static Future<bool> setLocalString(DbEnum key, String data) async {
    return await _instance.setString(key.name, data);
  }

  static String? getLocalString(DbEnum key) {
    return _instance.getString(key.name);
  }

  /// int
  static Future<bool> setLocalInt(DbEnum key, int data) async {
    return await _instance.setInt(key.name, data);
  }

  static int? getLocalInt(DbEnum key) {
    return _instance.getInt(key.name);
  }

  /// double
  static Future<bool> setLocalDouble(DbEnum key, double data) async {
    return await _instance.setDouble(key.name, data);
  }

  static double? getLocalDouble(DbEnum key) {
    return _instance.getDouble(key.name);
  }

  /// bool
  static Future<bool> setLocalBool(DbEnum key, bool data) async {
    return await _instance.setBool(key.name, data);
  }

  static dynamic getLocalBool(DbEnum key) {
    return _instance.getBool(key.name);
  }

  ///custom
  static Future<bool> removeLocal(DbEnum key) async {
    return await _instance.remove(key.name);
  }

  static Future<bool> clearLocalData() async {
    return await _instance.clear();
  }
}

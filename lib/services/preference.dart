import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<bool> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  static bool? getBool(String key) => _prefs.getBool(key);

  static String? getString(String key) => _prefs.getString(key);

  static Future<bool> remove(String key) async => await _prefs.remove(key);
}

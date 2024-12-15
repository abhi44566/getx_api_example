import 'package:shared_preferences/shared_preferences.dart';

class MySession {
  static final Future<SharedPreferences> _prefs =
  SharedPreferences.getInstance();

  static Future<void> init() async {
    await _prefs;
  }

  static Future<void> setUserId(String id) async {
    final prefs = await _prefs;
    await prefs.setString('userId', id);
  }

  static Future<String> getUserId() async {
    final prefs = await _prefs;
    return prefs.getString('userId') ?? '';
  }
}
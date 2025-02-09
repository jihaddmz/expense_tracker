import 'package:shared_preferences/shared_preferences.dart';

class HelperSharedPref {
  static late SharedPreferences _prefs;

  static Future<void> setInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setName(String name) async {
    await _prefs.setString("name", name);
  }

  static String getName() {
    return _prefs.getString("name") ?? "";
  }

  static Future<void> setEmail(String email) async {
    await _prefs.setString("email", email);
  }

  static String getEmail() {
    return _prefs.getString("email") ?? "";
  }

  static Future<void> setIsSignedUp(bool signedUp) async {
    await _prefs.setBool("isSignedUp", signedUp);
  }

  static bool isSignedUp() {
    return _prefs.getBool("isSignedUp") ?? false;
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }
}

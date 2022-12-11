import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static const String isSignedIn = 'IS_SIGNED_IN';
  static const String token = 'TOKEN';

  static Future<bool> checkIsSignedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isSignedIn) ?? false;
  }

  static Future<bool> saveSession(String bearerToken) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(isSignedIn, true);
    return await preferences.setString(token, bearerToken);
  }

  static Future<void> clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static Future<String> getBearerToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(token) ?? '';
  }
}

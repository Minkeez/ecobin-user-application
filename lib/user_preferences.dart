import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> isFirstTimeUser() async {
    bool firstTime = _preferences.getBool('first_time_user') ?? true;
    if (firstTime) {
      await _preferences.setBool('first_time_user', false);
    }
    return firstTime;
  }
}

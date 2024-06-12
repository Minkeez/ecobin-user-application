import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyUserName = 'user_name';
  static const _keyPhoneNumber = 'phone_number';
  static const _keyFirstTimeUser = 'first_time_user';
  static const _keyTotalPoints = 'total_points';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> isFirstTimeUser() async {
    bool firstTime = _preferences.getBool('first_time_user') ?? true;
    if (firstTime) {
      await _preferences.setBool(_keyFirstTimeUser, false);
    }
    return firstTime;
  }

  static Future<void> saveUserName(String userName) async {
    await _preferences.setString(_keyUserName, userName);
  }

  static Future<void> savePhoneNumber(String phoneNumber) async {
    await _preferences.setString(_keyPhoneNumber, phoneNumber);
  }

  static Future<void> saveTotalPoints(int points) async {
    await _preferences.setInt(_keyTotalPoints, points);
  }

  static String? getUserName() {
    return _preferences.getString(_keyUserName);
  }

  static String? getPhoneNumber() {
    return _preferences.getString(_keyPhoneNumber);
  }

  static int getTotalPoints() {
    return _preferences.getInt(_keyTotalPoints) ?? 0;
  }
}

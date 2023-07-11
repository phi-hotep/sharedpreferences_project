import 'package:shared_preferences/shared_preferences.dart'; //1

class UserPref {
  //2
  static const kuserCommute = 'commute';
  static const kuserCount = 'count';

  //3
  static void saveCommuteValue(bool value) async {
    final prefs = await SharedPreferences.getInstance(); //4
    await prefs.setBool(UserPref.kuserCommute, value); //5
  }

  //6
  static void saveCountValue(int value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(UserPref.kuserCount, value);
  }
}

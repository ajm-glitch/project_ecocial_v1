import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceActions {
  Future<void> updateFirstTime(bool firstTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstTime', firstTime);
  }

  Future<String> firstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final firstTimeUser = prefs.getBool('firstTime');
    if (firstTimeUser == null) {
      return 'true';
    } else {
      return 'false';
    }
  }
}

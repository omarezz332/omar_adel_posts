import 'package:shared_preferences/shared_preferences.dart';

mixin AppSharedPrefs {
  static late SharedPreferences? _sharedPreferences;
  static SharedPreferences get instance => _sharedPreferences!;

  static Future<void> ensureInit() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}

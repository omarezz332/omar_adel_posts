import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/app_shared_prefs.dart';
import '../../../helpers/storage_keys.dart';
import '../../../models/core/user.dart';
import '../interfaces/i_user_repository.dart';
final userRepository = Provider<IUserRepository>((ref) => UserRepository());

class UserRepository implements IUserRepository {
  final SharedPreferences _sharedPreferences;
  UserRepository() : _sharedPreferences = AppSharedPrefs.instance;
  @override
  void delete() {
    _sharedPreferences.remove(kUser);
  }

  @override
  bool exist() {
    return _sharedPreferences.containsKey(kUser);
  }

  @override
  UserData get() {
    final userString = _sharedPreferences.getString(kUser);
    final decodedUser = json.decode(userString!);
    return UserData.fromJson(decodedUser as Map<String, dynamic>);
  }

  @override
  Future<void> set(UserData user) async {
    final String encodedUser = json.encode(user.toJson());
    await _sharedPreferences.setString(kUser, encodedUser);
  }
}

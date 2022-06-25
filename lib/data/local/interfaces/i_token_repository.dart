import 'package:firebase_auth/firebase_auth.dart';

abstract class ITokenRepository {
  Future<String> getToken();
  Future<void> deleteToken();
  Future<void> setToken(String newToken);
  Future<void> setUser(User newUser);
  Future<User?> getUser();
}

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../helpers/storage_keys.dart';
import '../interfaces/i_token_repository.dart';

final tokenRepository = Provider<ITokenRepository>((ref) => TokenRepository());
class TokenRepository implements ITokenRepository {
  final FlutterSecureStorage _secureStorage;

  //* Constructor
  TokenRepository() : _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: kToken);
  }

  @override
  Future<String> getToken() async {
    try {
      final hasKey = await _secureStorage.containsKey(key: kToken);
      if (hasKey) {
        final String? token = await _secureStorage.read(key: kToken);
        return token!;
      }
      return '';
    } on PlatformException {
      await _secureStorage.delete(key: kToken);
      return '';
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  @override
  Future<void> setToken(String token) async {
    await _secureStorage.write(key: kToken, value: token);
  }


  @override
  Future<void> setUser(User newUser) async {
    await _secureStorage.write(key: kUser, value: json.encode(newUser.toString()));


  }

  @override
  Future<User?> getUser()async {
    try {
      final hasKey = await _secureStorage.containsKey(key: kUser);
      if (hasKey) {
        final String? user = await _secureStorage.read(key: kUser);
        log('user: $user');
        return json.decode(user!);
      }
    } on PlatformException {
      await _secureStorage.delete(key: kUser);
    } catch (e) {
      debugPrint(e.toString());
    }

  }

}

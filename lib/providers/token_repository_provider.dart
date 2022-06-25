import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/interfaces/i_token_repository.dart';
import '../data/local/repositories/token_repository.dart';


final tokenRepositoryProvider = ChangeNotifierProvider(
      (ref) => TokenRepositoryProvider(ref.read(tokenRepository)),
);

class TokenRepositoryProvider extends ChangeNotifier {
  final ITokenRepository _tokenRepository;

  TokenRepositoryProvider(this._tokenRepository);

  String _token = '';
  User? _user;

  String get token => _token;
  User? get user => _user;
bool get hasToken => _token.isNotEmpty;
  set token(String value) {
    _token = value;
    notifyListeners();
  }

  Future<void> getToken() async {
    final repositoryToken = await _tokenRepository.getToken();
log('repositoryToken: $repositoryToken');
    if (repositoryToken != '') {
      token = repositoryToken;
    }
  }
  Future<void> getUser() async {
    final repositoryToken = await _tokenRepository.getUser();

      _user = repositoryToken;

  }

  Future<void> setToken(String newToken) async {
    await _tokenRepository.setToken(newToken);
    token = newToken;
    log('TokenRepositoryProvider: setToken: $newToken');
  }
  Future<void> setUser(User newUser) async {
    await _tokenRepository.setUser(newUser);
    _user = newUser;
    log('TokenRepositoryProvider: setUser: $newUser');
  }
  Future<void> deleteToken() async {
    await _tokenRepository.deleteToken();
    token = '';
  }
}

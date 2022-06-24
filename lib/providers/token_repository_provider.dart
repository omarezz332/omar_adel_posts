import 'dart:developer';

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

  String get token => _token;

  set token(String value) {
    _token = value;
    notifyListeners();
  }

  Future<void> getToken() async {
    final repositoryToken = await _tokenRepository.getToken();

    if (repositoryToken != '') {
      token = repositoryToken;
    }
  }

  Future<void> setToken(String newToken) async {
    await _tokenRepository.setToken(newToken);
    token = newToken;
    log('TokenRepositoryProvider: setToken: $newToken');
  }

  Future<void> deleteToken() async {
    await _tokenRepository.deleteToken();
    token = '';
  }
}

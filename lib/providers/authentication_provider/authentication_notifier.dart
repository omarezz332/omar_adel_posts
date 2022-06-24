import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/interfaces/i_user_repository.dart';
import '../../data/local/repositories/user_repository.dart';
import '../../data/remote/apis/authentication_api.dart';
import '../../data/remote/interfaces/i_authentication_api.dart';
import '../../models/core/login_data.dart';
import '../../models/core/user.dart';
import '../fields_providers/login_field_provider.dart';
import '../token_repository_provider.dart';
import 'authentication_state.dart';


final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
  (ref) => AuthenticationNotifier(
    ref.read(authenticationApi),
    ref.read(loginFieldProviderRef),
    ref.read(tokenRepositoryProvider),
    ref.read(userRepository),
  ),
);

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  final IAuthenticationApi _api;
  final LoginFieldProvider _loginFieldProvider;
  final TokenRepositoryProvider _tokenRepositoryProvider;
  final IUserRepository _userRepository;
  AuthenticationNotifier(
    this._api,
    this._loginFieldProvider,
    this._tokenRepositoryProvider,
    this._userRepository,
  ) : super(const AuthenticationInitial());

  Future<void> init() async {
    if (_tokenRepositoryProvider.token.isNotEmpty) {
      await _tokenRepositoryProvider.getToken();
        state = Authenticated(_tokenRepositoryProvider.token);
    }
  }

  Future<void> login() async {
    state = const AuthenticationLoading();
    try {
      final response = await _api.login(_loginFieldProvider.loginRequest);
      await saveAuthData(response!);
      state = Authenticated(response.uid);
    } catch (e) {
      state = const AuthenticationInitial();
      rethrow;
    }
  }

  Future<void> saveAuthData(User user) async {
    await _tokenRepositoryProvider.setToken(user.uid);
  }



  Future<void> logout() async {
    _userRepository.delete();
    _tokenRepositoryProvider.deleteToken();
    state = const UnAuthenticated();
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/interfaces/i_user_repository.dart';
import '../../data/local/repositories/user_repository.dart';
import '../../data/remote/apis/authentication_api.dart';
import '../../data/remote/interfaces/i_authentication_api.dart';
import '../../models/core/login_data.dart';
import '../../models/core/post.dart';
import '../../models/core/user.dart';
import '../fields_providers/login_field_provider.dart';
import '../posts_provider/token_repository_provider.dart';
import '../token_repository_provider.dart';
import 'authentication_state.dart';


final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
  (ref) => AuthenticationNotifier(
    ref.read(authenticationApi),
    ref.read(loginFieldProviderRef),
    ref.read(tokenRepositoryProvider),
    ref.read(userRepository),
    ref.read(postsRepositoryProvider),
  ),
);

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  final IAuthenticationApi _api;
  final LoginFieldProvider _loginFieldProvider;
  final TokenRepositoryProvider _tokenRepositoryProvider;
  final IUserRepository _userRepository;
  final PostsRepositoryProvider _postsRepositoryProvider;
  AuthenticationNotifier(
    this._api,
    this._loginFieldProvider,
    this._tokenRepositoryProvider,
    this._userRepository,
    this._postsRepositoryProvider,
  ) : super(const AuthenticationInitial());

  Future<void> init() async {

      await _tokenRepositoryProvider.getToken();
     // await _tokenRepositoryProvider.getUser();
      log(_tokenRepositoryProvider.user.toString());
      state=Authenticated(_tokenRepositoryProvider.user);
      await  _postsRepositoryProvider.getPosts();
      log("got posts");

  }
  User? get user => state is Authenticated
      ? (state as Authenticated).user
      : null;
  Future<void> login() async {
    state = const AuthenticationLoading();
    try {
      final response = await _api.login(_loginFieldProvider.loginRequest);
      await saveAuthData(response!);
      state = Authenticated(response);
    } catch (e) {
      state = const AuthenticationInitial();
      rethrow;
    }
  }

  Future<void> saveAuthData(User user) async {
    await _tokenRepositoryProvider.setToken(user.uid);
    await _tokenRepositoryProvider.setUser(user);
  }


  Future<void> logout() async {
    _userRepository.delete();
    _tokenRepositoryProvider.deleteToken();
    state = const UnAuthenticated();
  }
}

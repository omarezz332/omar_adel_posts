import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/models/core/login_data.dart';
import '../../data/remote/apis/authentication_api.dart';
import '../../data/remote/interfaces/i_authentication_api.dart';
import '../fields_providers/register_field_provider.dart';

final registerNotifierProviderRef =
    StateNotifierProvider<RegisterNotifier, bool>((
  ref,
) {
  return RegisterNotifier(
    ref.read(authenticationApi),
    ref.read(registerFieldProviderRef),
  );
});

class RegisterNotifier extends StateNotifier<bool> {
  final IAuthenticationApi _api;
  final RegisterFieldProvider _registerFieldProvider;
  RegisterNotifier(this._api, this._registerFieldProvider) : super(false);

  Future<User?> register() async {
    state = true;
    try {
      final response =
          await _api.register(_registerFieldProvider.registerRequest);
      return response;
    } catch (e) {
      return null     ;
    } finally {
      state = false;
    }
  }
}

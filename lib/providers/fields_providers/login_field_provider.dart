import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/core/login_request.dart';

final loginFieldProviderRef =
    Provider<LoginFieldProvider>((ref) => LoginFieldProvider());

class LoginFieldProvider {
  LoginRequest loginRequest =  const LoginRequest();

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  void registerNewKey() {
    loginKey = GlobalKey<FormState>();
  }

  bool validate() {
    if (loginKey.currentState!.validate()) {
      loginKey.currentState!.save();
      return true;
    }
    return false;
  }

  void setEmail(String email) {
    print('setEmail: $email');
    loginRequest = loginRequest.copyWith(email: email);
  }

  void setPassword(String password) {
    print('setPassword: $password');
    loginRequest = loginRequest.copyWith(password: password);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/core/register_request.dart';

final registerFieldProviderRef =
    Provider<RegisterFieldProvider>((ref) => RegisterFieldProvider());

class RegisterFieldProvider {
  RegisterRequest registerRequest =  RegisterRequest();

  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  bool validate() {
    if (registerKey.currentState!.validate()) {
      registerKey.currentState!.save();
      return true;
    }
    return false;
  }

  void setEmail(String email) {
    registerRequest = registerRequest.copyWith(email: email);
  }


  void setPassword(String password) {
    registerRequest = registerRequest.copyWith(password: password);
  }

}

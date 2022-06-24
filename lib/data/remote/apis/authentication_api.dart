import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../helpers/storage_keys.dart';
import '../../../models/core/login_data.dart';
import '../../../models/core/login_request.dart';
import '../../../models/core/register_request.dart';
import '../endpoints.dart';
import '../interfaces/i_authentication_api.dart';
import 'package:http/http.dart' as http;

final authenticationApi = Provider<IAuthenticationApi>(
      (ref) => AuthenticationApi(),
);

class AuthenticationApi implements IAuthenticationApi {

  AuthenticationApi();
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  @override
  Future<User?> login(LoginRequest request) async {
    final url = Uri.parse(kSignIn);
    final response = await _firebaseAuth.signInWithEmailAndPassword(email: request.email, password: request.password);
  //final response = await http.post(url, body:  request.toJson());
    log(response.toString());
return response.user;
    // final LoginData successResponse =
    // LoginData.fromJson(response as Map<String, dynamic>);

  }


  @override
  Future<User?> register(RegisterRequest request) async {

      final url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$fireBaseToken");
   // const uri = kSignUp;
    log( request.toJson().toString());
  //  final response = await http.post(url, body:  request.toJson());


      final response =await _firebaseAuth.createUserWithEmailAndPassword(email: request.email, password: request.password);
      log( response.toString());
   // final Null successResponse = null;
    //LoginData.fromJson(response as Map<String, dynamic>);
    return response.user;
  }
}

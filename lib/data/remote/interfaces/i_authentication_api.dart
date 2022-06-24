import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/core/login_data.dart';
import '../../../models/core/login_request.dart';
import '../../../models/core/register_request.dart';

abstract class IAuthenticationApi {
  Future<User?> login(LoginRequest request);

  Future<User?> register(RegisterRequest request);

}

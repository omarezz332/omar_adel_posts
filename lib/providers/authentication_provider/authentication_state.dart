
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

class Authenticated extends AuthenticationState {
  final User? user;
  const Authenticated(this.user);
}

class UnAuthenticated extends AuthenticationState {
  const UnAuthenticated();
}


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
  final String token;
  const Authenticated(this.token);
}

class UnAuthenticated extends AuthenticationState {
  const UnAuthenticated();
}

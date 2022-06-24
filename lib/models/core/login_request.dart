import 'package:json_annotation/json_annotation.dart';
import 'package:omar_adel_posts/models/core/login_data.dart';
part 'login_request.g.dart';

@JsonSerializable(explicitToJson: true,)
class LoginRequest {
  final String email;
  final String password;
  final bool returnSecureToken;
  const LoginRequest({
    this.email = '',
    this.password = '',
    this.returnSecureToken = true,
  });

  LoginRequest copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      returnSecureToken: true,
    );
  }
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

}
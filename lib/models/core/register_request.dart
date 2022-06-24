
import 'package:json_annotation/json_annotation.dart';
import 'package:omar_adel_posts/models/core/login_data.dart';
part 'register_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterRequest {
  final String email;
  final String password;
  final bool returnSecureToken;

  const RegisterRequest({
    this.email = '',
    this.password = '',
    this.returnSecureToken= true,
  });
  RegisterRequest copyWith({
    String? email,
    String? password,
    bool? returnSecureToken,
  }) {
    return RegisterRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      returnSecureToken: returnSecureToken ?? this.returnSecureToken,
    );
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
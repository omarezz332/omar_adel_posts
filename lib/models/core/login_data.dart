
import 'package:json_annotation/json_annotation.dart';

part 'login_data.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginData {
  final String idToken;
 final  String refreshToken;
  final String expiresIn;

   LoginData(this.idToken, this.expiresIn, this.refreshToken);

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

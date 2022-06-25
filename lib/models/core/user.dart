import 'package:json_annotation/json_annotation.dart';


part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)


class UserData {
  int? id;
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePhoto;
  String? avatar;
  String? profileBackgroundImage;


  UserData(
      {this.id,
        this.fullName,
        this.firstName,
        this.lastName,
        this.email,
        this.profilePhoto,
        this.avatar,
        this.profileBackgroundImage,
});
      factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
      Map<String, dynamic> toJson() => _$UserDataToJson(this);

}


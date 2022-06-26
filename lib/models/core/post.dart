

import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';
@JsonSerializable(explicitToJson: true,)
class Posts {
  String? id;
  String? image;
  String? description;
  String? userId;
  List<dynamic> ?likes=[""];
  List<dynamic> ?saves=[""];
  bool? isLiked;
  bool? isSaved;

  Posts ({
    this.id,
    this.image,
    this.description,
    this.userId,
    this.likes,
    this.isLiked,
    this.isSaved,
    this.saves,
  });
  Posts copyWith({
    String? id,
    String? image,
    String? description,
    String? userId,
    List<String>? likes,
    bool? isLiked,
    bool? isSaved,
    List<String>? saves,
  }) {
    return Posts(
      id: id ?? this.id,
      image: image ?? this.image,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      likes: likes ?? [""],
      isLiked: isLiked ?? false,
      isSaved: isSaved ?? false,
      saves: saves ?? [""],
    );
  }
  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
  Map<String, dynamic> toJson() => _$PostsToJson(this);

}
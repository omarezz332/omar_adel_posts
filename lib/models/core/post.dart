

import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';
@JsonSerializable(explicitToJson: true,)
class Posts {
 final String? id;
 final String? image;
 final String? description;
 final String? userId;
 final int? likes;
 final bool? isLiked;
 final bool? isSaved;

  Posts ({
    this.id,
    this.image,
    this.description,
    this.userId,
    this.likes,
    this.isLiked,
    this.isSaved,
  });
  Posts copyWith({
    String? id,
    String? image,
    String? description,
    String? userId,
    int? likes,
    bool? isLiked,
    bool? isSaved,
  }) {
    return Posts(
      id: id ?? this.id,
      image: image ?? this.image,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      likes: likes ?? 2,
      isLiked: isLiked ?? false,
      isSaved: isSaved ?? false,
    );
  }
  factory Posts.fromJson(Map<String, dynamic> json) => _$PostsFromJson(json);
  Map<String, dynamic> toJson() => _$PostsToJson(this);

}
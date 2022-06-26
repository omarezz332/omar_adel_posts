// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Posts _$PostsFromJson(Map<String, dynamic> json) => Posts(
      id: json['id'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      userId: json['userId'] as String?,
      likes: json['likes'] as List<dynamic>?,
      isLiked: json['isLiked'] as bool?,
      isSaved: json['isSaved'] as bool?,
      saves: json['saves'] as List<dynamic>?,
    );

Map<String, dynamic> _$PostsToJson(Posts instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'description': instance.description,
      'userId': instance.userId,
      'likes': instance.likes,
      'saves': instance.saves,
      'isLiked': instance.isLiked,
      'isSaved': instance.isSaved,
    };

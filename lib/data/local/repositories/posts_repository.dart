import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:omar_adel_posts/models/core/post.dart';
import '../../../helpers/storage_keys.dart';
import '../interfaces/i_posts_repository.dart';
import '../interfaces/i_token_repository.dart';

final postsRepository = Provider<IPostsRepository>((ref) => PostsRepository());
class PostsRepository implements IPostsRepository {
  final FlutterSecureStorage _secureStorage;

  //* Constructor
  PostsRepository() : _secureStorage = const FlutterSecureStorage();



  @override
  Future<List<Posts>> getPosts()async  {
    List<Posts> posts = [];
    try {
      final hasKey = await _secureStorage.containsKey(key: kPosts);
      if (hasKey) {

        final String? _posts = await _secureStorage.read(key: kPosts);
        log("hasPosts: $_posts");
        final Map<String, dynamic> extractedData = json.decode(_posts!);
        debugPrint("hasPosts: $extractedData");

        extractedData.forEach((userId, orderData) {
          orderData.forEach((id, value) {
            posts.add(Posts(
              userId:userId ,
              id: id,
              image: value['image'],
              description: value['description'],
              isLiked: value['isLiked'],
              likes: value['likes'],
              saves: value['saves'],
              isSaved: value['isSaved'],
            ));
          });

        });
        log("hasPosts: ${posts[0].description}");
        return posts  ;
      }
      return [];
    } on PlatformException {

      await _secureStorage.delete(key: kPosts);
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      return posts;
    }
  }

  @override
  Future<void> setPosts(Map<String,dynamic> posts) async {
    String result = json.encode(posts);
    log('result: $result');
    await _secureStorage.write(key: kPosts, value:result );



  }
}


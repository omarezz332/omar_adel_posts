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
        if (_posts != '') {
         // posts = json.decode(_posts).map<Posts>((json) => Posts.fromJson(json)).toList();
          posts = json.decode(_posts!).map((e) => Posts.fromJson(e)).toList();
          log('result: ${posts[0]}');
        }
        return posts  ;
      }
      return [];
    } on PlatformException {

      await _secureStorage.delete(key: kPosts);
    } catch (e) {
      debugPrint(e.toString());
    }finally{
      return [];
    }
  }

  @override
  Future<void> setPosts(List<Posts> posts) async {
    String result = json.encode(posts.map((e) => e.toJson()).toList());
    log('result: $result');
    await _secureStorage.write(key: kPosts, value:result );



  }
}


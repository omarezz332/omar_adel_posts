import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/data/local/interfaces/i_posts_repository.dart';

import '../../data/local/repositories/posts_repository.dart';
import '../../models/core/post.dart';


final postsRepositoryProvider = ChangeNotifierProvider(
      (ref) => PostsRepositoryProvider(ref.read(postsRepository)),
);

class PostsRepositoryProvider extends ChangeNotifier {
  final IPostsRepository _postsRepository;

  PostsRepositoryProvider(this._postsRepository);

  List<Posts> _posts=[];

  List<Posts> get posts => _posts;
  void updatePosts(List<Posts> posts) {
    _posts = posts;
  }


  Future<List<Posts>> getPosts() async {
    final repositoryPosts = await _postsRepository.getPosts();

log('repositoryPosts: $repositoryPosts');
    if (repositoryPosts != '') {
      _posts = repositoryPosts;
      return _posts;
    }
    return [];
  }


  Future<void> setPost(List<Posts> posts,Map<String,dynamic> extractedData) async {
    await _postsRepository.setPosts(extractedData);
    _posts = posts;
    log('TokenRepositoryProvider: setToken: ${posts.length}');
    notifyListeners();

  }

}

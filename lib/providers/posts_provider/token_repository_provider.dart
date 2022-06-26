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


  Future<List<Posts>> getPosts() async {
    final repositoryPosts = await _postsRepository.getPosts();

log('repositoryPosts: $repositoryPosts');
    if (repositoryPosts != '') {
      _posts = repositoryPosts;
      return _posts;
    }
    return [];
  }


  Future<void> setPost(List<Posts> posts) async {
    await _postsRepository.setPosts(posts);
    _posts = posts;
    log('TokenRepositoryProvider: setToken: ${posts.length}');
  }

}

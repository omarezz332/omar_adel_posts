import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/data/local/repositories/posts_repository.dart';
import 'package:omar_adel_posts/data/remote/interfaces/i_posts_api.dart';
import 'package:omar_adel_posts/models/core/post.dart';
import 'package:omar_adel_posts/providers/fields_providers/post_field_provider.dart';
import 'package:omar_adel_posts/providers/posts_provider/token_repository_provider.dart';

import '../../data/local/interfaces/i_user_repository.dart';
import '../../data/local/repositories/user_repository.dart';
import '../../data/remote/apis/authentication_api.dart';
import '../../data/remote/apis/posts_api.dart';
import '../../data/remote/interfaces/i_authentication_api.dart';
import '../../models/core/login_data.dart';
import '../../models/core/user.dart';
import '../fields_providers/login_field_provider.dart';
import '../token_repository_provider.dart';
import 'posts_state.dart';

final postsNotifierProvider = StateNotifierProvider<PostsNotifier, PostsState>(
  (ref) => PostsNotifier(
    ref.read(postsApiProvider),
    ref.read(postFieldProviderRef),
    ref.read(tokenRepositoryProvider),
    ref.read(postsRepositoryProvider),
  ),
);

class PostsNotifier extends StateNotifier<PostsState> {
  final IPostsApi _api;
  final PostFieldProvider _postFieldProvider;
  final TokenRepositoryProvider _tokenRepositoryProvider;
  final PostsRepositoryProvider _postsRepositoryProvider;

  PostsNotifier(
    this._api,
    this._postFieldProvider,
    this._tokenRepositoryProvider,
    this._postsRepositoryProvider,
  ) : super(const PostsInitial());

  Future<void> init() async {
   // state = const PostsLoading();
    if(_postsRepositoryProvider.posts.isEmpty) {

      if (_tokenRepositoryProvider.hasToken) {
        final posts = await _api.fetchPosts();
      //  _postsRepositoryProvider.setPost(posts);

      }
    }
    else
      await  _postsRepositoryProvider.getPosts();

    state = const Posted();
   // _postsRepositoryProvider.getPosts();
    // if (_tokenRepositoryProvider.token.isNotEmpty) {
    //   await _tokenRepositoryProvider.getToken();
    //     state = Posted(_tokenRepositoryProvider.token);
    // }
  }

  Future<void> addPost() async {
    state = const PostsLoading();
    try {
    await _api.addPost(
          _postFieldProvider.post, _tokenRepositoryProvider.token);
      _postsRepositoryProvider.posts.add(_postFieldProvider.post);
      _postsRepositoryProvider.setPost(_postsRepositoryProvider.posts);


      state = Posted();

      state = const Posted();
    } catch (e) {
      state = const PostsInitial();
      rethrow;
    }
  }

  Future<void> getPosts() async {
    state = const PostsLoading();
    try {
      final response = await _api.fetchPosts();
      //await saveAuthData(response!);
      state = const Posted();
    } catch (e) {
      state = const PostsInitial();
      rethrow;
    }
  }
}

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

      if (_postsRepositoryProvider.posts.isEmpty) {
        state = const PostsLoading();
        log("trying to get posts");
        final Map map = await _api.fetchPosts();
       await _postsRepositoryProvider.setPost(map['posts'], map['extractedData']);
        log("got posts${map['posts'].length}");
      }
      else {
        await  _postsRepositoryProvider.getPosts();
      }



    state = const Posted();
   // _postsRepositoryProvider.getPosts();
    // if (_tokenRepositoryProvider.token.isNotEmpty) {
    //   await _tokenRepositoryProvider.getToken();
    //     state = Posted(_tokenRepositoryProvider.token);
    // }
  }
  List<Posts> get savedPosts {
    List<Posts> _savedPosts = [];
    _postsRepositoryProvider.posts.forEach((post) {
      if (post.saves!.contains(_tokenRepositoryProvider.token)) {
        _savedPosts.add(post);
      }
    });
    return _savedPosts;

  }

  Future<void> addPost() async {
    state = const PostsLoading();
    try {
   final response = await _api.addPost(
          _postFieldProvider.post, _tokenRepositoryProvider.token);
   _postFieldProvider.post.id=json.decode(response.body)['name'];
      _postsRepositoryProvider.posts.add(_postFieldProvider.post);
    final Map map = await _api.fetchPosts();
    _postsRepositoryProvider.setPost(map['posts'], map['extractedData']);
      state = const Posted();
    } catch (e) {
      state = const PostsInitial();
      rethrow;
    }
  }
  Future<void> updatePost(Posts post) async {
   // state = const PostsLoading();
    try {
      await _api.updatePosts(
          post, _tokenRepositoryProvider.token);
      _postsRepositoryProvider.posts.add(_postFieldProvider.post);
      final Map map = await _api.fetchPosts();
      _postsRepositoryProvider.setPost(map['posts'], map['extractedData']);
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

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/data/remote/interfaces/i_posts_api.dart';
import 'package:omar_adel_posts/providers/fields_providers/post_field_provider.dart';

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


final postsNotifierProvider =
    StateNotifierProvider<PostsNotifier, PostsState>(
  (ref) => PostsNotifier(
   ref.read(postsApiProvider),
    ref.read(postFieldProviderRef),
    ref.read(tokenRepositoryProvider),
  ),
);

class PostsNotifier extends StateNotifier<PostsState> {
  final IPostsApi _api;
  final PostFieldProvider _postFieldProvider;
  final TokenRepositoryProvider _tokenRepositoryProvider;

  PostsNotifier(
    this._api,
    this._postFieldProvider,
    this._tokenRepositoryProvider,

  ) : super(const PostsInitial());

  Future<void> init() async {
    // if (_tokenRepositoryProvider.token.isNotEmpty) {
    //   await _tokenRepositoryProvider.getToken();
    //     state = Posted(_tokenRepositoryProvider.token);
    // }
  }

  Future<void> addPost() async {
    state = const PostsLoading();
    try {
      final response = await _api.addPost(_postFieldProvider.post , _tokenRepositoryProvider.token);
      //await saveAuthData(response!);
    //  _postFieldProvider.setId(  (response as )

      state =  const Posted();
    } catch (e) {
      state = const PostsInitial();
      rethrow;
    }
  }

Future<void> getPosts() async {
    state = const PostsLoading();
    try {
      final response = await _api.fetchPosts(_tokenRepositoryProvider.token);
      //await saveAuthData(response!);
      state =  const Posted();
    } catch (e) {
      state = const PostsInitial();
      rethrow;
    }
  }


}

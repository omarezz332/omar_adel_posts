import 'package:firebase_auth/firebase_auth.dart';
import 'package:omar_adel_posts/models/core/post.dart';

abstract class IPostsRepository {
  Future<List<Posts>> getPosts();
  Future<void> setPosts(Map<String,dynamic> posts);
}

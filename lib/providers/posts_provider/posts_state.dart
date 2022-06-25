
import 'package:omar_adel_posts/models/core/post.dart';

abstract class PostsState {
  const PostsState();
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class Posted extends PostsState {

  const Posted();
}


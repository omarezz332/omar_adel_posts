import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:omar_adel_posts/models/core/post.dart';

import '../../../models/core/login_data.dart';
import '../../../models/core/login_request.dart';
import '../../../models/core/register_request.dart';

abstract class IPostsApi {
Future<dynamic> addPost(Posts post, String token);
Future<List<Posts>> fetchPosts( String token );
}



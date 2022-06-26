import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/data/remote/interfaces/i_posts_api.dart';
import 'package:omar_adel_posts/models/core/post.dart';

import '../../../helpers/storage_keys.dart';
import '../../../models/core/login_data.dart';
import '../../../models/core/login_request.dart';
import '../../../models/core/register_request.dart';
import '../endpoints.dart';
import '../interfaces/i_authentication_api.dart';
import 'package:http/http.dart' as http;

final postsApiProvider = Provider<IPostsApi>(
      (ref) => PostsApi(),
);

class PostsApi implements IPostsApi {

  PostsApi();

  @override
  Future<dynamic> addPost(Posts post, String token ) async {
    List<Posts> posts = [];
    final url = Uri.parse('https://omaradelposts-default-rtdb.firebaseio.com/posts/$token.json');
   // log(post.image ?? 'no image');
    final response = await http.post(url,body: json.encode(post.toJson()));
    json.decode(response.body)['name'];
log("kafjsklfaskl ${json.decode(response.body)['name']}");
return response;



  }

  @override
  Future<Map<String,dynamic>> fetchPosts(  ) async {
    List<Posts> posts = [];

final url = Uri.parse('https://omaradelposts-default-rtdb.firebaseio.com/posts.json');
final response = await http.get(url);
     log("fetchPosts : ${response.body.toString()}");
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    extractedData.forEach((userId, orderData) {
      orderData.forEach((id, value) {
          posts.add(Posts(
            userId:userId ,
            id: id,
            image: value['image'],
            description: value['description'],
            isLiked: value['isLiked'],
            likes: value['likes'] ,
            isSaved: value['isSaved'],
          ));
      });

    });
    return {
      'posts': posts,
      'extractedData': extractedData,
    };
     // final LoginData successResponse =
    // LoginData.fromJson(response as Map<String, dynamic>);

   }

  @override
  Future updatePosts(Posts post, String token) async{

    final url = Uri.parse('https://omaradelposts-default-rtdb.firebaseio.com/posts/$token/${post.id}.json');
    final response = await http.patch(url,body: json.encode(post.toJson()));
    log("updateLikes : ${response.body.toString()}");
    return response;
  }


//   @override
//   Future<User?> login(LoginRequest request) async {
//    // final url = Uri.parse(kPosts);
//     final response = await _firebaseAuth.signInWithEmailAndPassword(email: request.email, password: request.password);
//
//     log(response.toString());
// return response.user;
//     // final LoginData successResponse =
//     // LoginData.fromJson(response as Map<String, dynamic>);
//
//   }
//
//
//   @override
//   Future<User?> register(RegisterRequest request) async {
//
//       final url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$fireBaseToken");
//    // const uri = kSignUp;
//     log( request.toJson().toString());
//   //  final response = await http.post(url, body:  request.toJson());
//
//
//       final response =await _firebaseAuth.createUserWithEmailAndPassword(email: request.email, password: request.password);
//       log( response.toString());
//    // final Null successResponse = null;
//     //LoginData.fromJson(response as Map<String, dynamic>);
//     return response.user;
//   }
}
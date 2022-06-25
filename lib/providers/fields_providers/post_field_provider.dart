import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/models/core/post.dart';
import '../../models/core/login_request.dart';

final postFieldProviderRef =
    Provider<PostFieldProvider>((ref) => PostFieldProvider());

class PostFieldProvider {
  Posts post =  Posts();

  GlobalKey<FormState> postKey = GlobalKey<FormState>();

  void registerNewKey() {
    postKey = GlobalKey<FormState>();
  }

  bool validate() {
    if (postKey.currentState!.validate()) {
      postKey.currentState!.save();
      return true;
    }
    return false;
  }

  void setDescription(String description) {
    post = post.copyWith(description:description );
  }
  void setId(String id) {
    post = post.copyWith(id: id );
  }
  void setImage(String image) {
    post = post.copyWith(image: image );
  }
  String? getImage() {
    return post.image;
  }



}

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omar_adel_posts/generated/locale_keys.g.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';
import 'package:omar_adel_posts/models/core/post.dart';
import 'package:omar_adel_posts/providers/posts_provider/posts_notifier.dart';

class MySavedPostsScreen extends ConsumerStatefulWidget {
  const MySavedPostsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MySavedPostsScreen> createState() => _State();
}

class _State extends ConsumerState<MySavedPostsScreen> {
  List<Posts> posts = [];
  @override
  Widget build(BuildContext context) {
    posts = ref.watch(postsNotifierProvider.notifier).savedPosts;
    return Scaffold(      backgroundColor: context.theme.scaffoldBackgroundColor,


      appBar: AppBar(
        title: Text(LocaleKeys.user_actions_saved_posts.tr()),
      ),
      body:posts.isEmpty?Center(
        child: Text(LocaleKeys.user_actions_no_saved_posts.tr()),
      ):
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15.0)),
                        child: Image.memory(
                          base64Decode(posts[index].image ?? ""),

                          height: ScreenUtil().setHeight(200),
                          width: ScreenUtil().setWidth(350),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(posts[index].description ?? "",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            color: context.theme.primaryColor,
                          )),
                    ),
                  ],
                ),
              );
            }),
      ),);

  }
}

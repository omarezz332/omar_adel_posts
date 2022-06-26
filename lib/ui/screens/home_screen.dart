import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';
import 'package:omar_adel_posts/models/core/post.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/locale_keys.g.dart';
import '../../providers/posts_provider/posts_notifier.dart';
import '../../providers/posts_provider/posts_state.dart';
import '../../providers/posts_provider/token_repository_provider.dart';
import '../dialogs/create_post_dialog.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(postsNotifierProvider.notifier).init();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.user_actions_Main.tr()),
      ),
      drawer: AppDrawer(),
      body: _getposts(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const CreatePostDialog(),
          );
        },
        tooltip: LocaleKeys.user_actions_publish.tr(),
        child: const Icon(Icons.add),
      ),

      //body:,
    );
  }

  Widget _getposts() {
    return Consumer(builder: (_, ref, __) {
      var loading = ref.watch(postsNotifierProvider.notifier).state is PostsLoading ;
      List<Posts> posts = ref.watch(postsRepositoryProvider).posts;
      return loading ? Center(child: CircularProgressIndicator())
          : ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Image.memory(
                  base64Decode(posts[index].image!),
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setWidth(400),
              fit: BoxFit.cover,
            ),
                  Text(posts[index].description!),
                ],
              ),
            );
          });
    });
  }
}

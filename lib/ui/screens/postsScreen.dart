
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';
import '../../generated/locale_keys.g.dart';
import '../../providers/posts_provider/posts_notifier.dart';
import '../../providers/posts_provider/posts_state.dart';
import '../dialogs/create_post_dialog.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_list.dart';
class PostsScreen extends ConsumerStatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends ConsumerState<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
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
      var loading = ref.watch(postsNotifierProvider) is PostsLoading ;

      return loading ? const Center(child: CircularProgressIndicator())
          : CustomList();
    });
  }
}

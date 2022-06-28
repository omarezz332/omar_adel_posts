import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';
import 'package:omar_adel_posts/models/core/post.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omar_adel_posts/ui/screens/postsScreen.dart';
import 'package:omar_adel_posts/ui/screens/profileScreen.dart';

import '../../generated/locale_keys.g.dart';
import '../../providers/posts_provider/posts_notifier.dart';
import '../../providers/posts_provider/posts_state.dart';
import '../../providers/posts_provider/token_repository_provider.dart';
import '../dialogs/create_post_dialog.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ref.read(postsNotifierProvider.notifier).init();
    var titleName= LocaleKeys.user_actions_Main.tr();
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
    //  animationDuration: const Duration(milliseconds: 300),
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          bottom: TabBar(
            //  indicatorSize: TabBarIndicatorSize.label,
            labelColor:Colors.white,

            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            onTap: (index) {
              if (index == 0) {
                titleName = LocaleKeys.user_actions_Main.tr();


              } else {
                titleName = LocaleKeys.user_actions_Main.tr();
              }
              setState(() {});
            },

            // indicator: BoxDecoration(
            //     borderRadius: BorderRadius.circular(17), //
            //     // Creates border
            //     color: Colors.white),
            tabs:  [
              Tab(
                text: LocaleKeys.user_actions_Main.tr(),
              ),
              Tab(
                text:   LocaleKeys.user_actions_profile.tr(),
              ),

            ],
          ),
        ),

        drawer: AppDrawer(),
        body:TabBarView(

          children: const [
            PostsScreen(),
            ProfileScreen(),
          ],

        ), //


        //body:,
      ),
    );
  }

}

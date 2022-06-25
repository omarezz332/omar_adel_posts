import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';

import '../../generated/locale_keys.g.dart';
import '../dialogs/create_post_dialog.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.user_actions_Main.tr()),
      ),
      drawer: AppDrawer(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const CreatePostDialog(),
          );
        },
        tooltip: LocaleKeys.user_actions_publish.tr(),
        child: Icon(Icons.add),
      ),

      //body:,
    );
  }
}

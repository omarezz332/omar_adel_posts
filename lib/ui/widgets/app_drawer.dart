import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';

import '../../generated/locale_keys.g.dart';
import '../../providers/authentication_provider/authentication_notifier.dart';
import '../../providers/authentication_provider/authentication_state.dart';
import '../../providers/fields_providers/login_field_provider.dart';
import '../../providers/fields_providers/register_field_provider.dart';
import '../../router/custom_router.gr.dart';
import '../dialogs/logout_alert_dialog.dart';
import '../screens/my_saved_posts_screen.dart';

class AppDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authenticationNotifierProvider.notifier).user;
    final user = (ref.watch(authenticationNotifierProvider.notifier)).user;
    return Drawer(
      backgroundColor: Colors.white,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: context.theme.backgroundColor,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: ScreenUtil().setSp(50),
                  ),
                  radius: 45.0.sp,
                ),
                Text(
                  user?.email ?? "أسم المستخدم",
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(20)),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('الصفحة الرئيسية'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('الملف الشخصي'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(LocaleKeys.user_actions_saved_posts.tr()),
            leading: Icon(Icons.bookmark),
            onTap: () {

              AutoRouter.of(context).push( const MySavedPostsRoute());
            },
          ),
          ListTile(
            title: Text(LocaleKeys.user_actions_logout.tr()),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              showDialog(
                  context: context, builder: (_) => const LogoutAlertDialog());
            },
          ),
        ],
      ),
    );
  }
}

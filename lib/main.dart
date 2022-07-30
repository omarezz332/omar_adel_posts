import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omar_adel_posts/router/custom_router.gr.dart';
import 'package:omar_adel_posts/theme/app_theme.dart';
import 'package:overlay_support/overlay_support.dart';

import 'generated/codegen_loader.g.dart';
import 'helpers/app_shared_prefs.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // custom initial helpers
  await EasyLocalization.ensureInitialized();
  await AppSharedPrefs.ensureInit();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ProviderScope(
    child: EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('ar')],
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter =
      AppRouter(); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 736),
        builder: (BuildContext context, Widget? child) {
          return OverlaySupport(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              routeInformationParser: _appRouter.defaultRouteParser(),
              routerDelegate: AutoRouterDelegate(_appRouter),
              builder: (context, child) {
                return AppTheme(navigator: child!);
              },
            ),
          );
        });
  }
}

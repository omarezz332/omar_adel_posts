import 'dart:developer';


import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../helpers/extensions.dart';
import '../../providers/authentication_provider/authentication_notifier.dart';
import '../../providers/authentication_provider/authentication_state.dart';
import '../../providers/token_repository_provider.dart';
import '../../router/custom_router.gr.dart';


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    navigateToScreen();
  }

  Future<void> navigateToScreen() async {
    ref.read(authenticationNotifierProvider.notifier).init();
    Future.delayed(const Duration(seconds: 2), () {
    //  final isAuth = ref.read(authenticationNotifierProvider) is Authenticated;
      final hasToken= ref.read(tokenRepositoryProvider).hasToken;
      log('hasToken: $hasToken');
      AutoRouter.of(context).pushAndPopUntil(
        hasToken ? const HomeRoute() : const AuthRoute(),
        predicate: (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/splash_background.png',
          ),
          fit: BoxFit.fill,
        ),
      ),

    );
  }
}

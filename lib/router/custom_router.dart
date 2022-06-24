import 'package:auto_route/annotations.dart';
import 'package:omar_adel_posts/router/custom_router.gr.dart';

import '../ui/screens/auth_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/register_screen.dart';
import '../ui/screens/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
    routes: <AutoRoute>[
      AutoRoute(page: SplashScreen,initial: true),
      AutoRoute(page: HomeScreen),
      AutoRoute(page: AuthScreen),AutoRoute(page: RegisterScreen),
    ]
)
class $AppRouter {}
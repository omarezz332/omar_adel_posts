import 'package:auto_route/annotations.dart';

import '../ui/screens/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
    routes: <AutoRoute>[
      AutoRoute(page: HomeScreen,initial: true),
    ]
)
class $AppRouter {}
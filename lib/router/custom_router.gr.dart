// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../ui/screens/auth_screen.dart' as _i3;
import '../ui/screens/home_screen.dart' as _i2;
import '../ui/screens/my_saved_posts_screen.dart' as _i5;
import '../ui/screens/register_screen.dart' as _i4;
import '../ui/screens/splash_screen.dart' as _i1;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    AuthRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.AuthScreen());
    },
    RegisterRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RegisterScreen());
    },
    MySavedPostsRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.MySavedPostsScreen());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(SplashRoute.name, path: '/'),
        _i6.RouteConfig(HomeRoute.name, path: '/home-screen'),
        _i6.RouteConfig(AuthRoute.name, path: '/auth-screen'),
        _i6.RouteConfig(RegisterRoute.name, path: '/register-screen'),
        _i6.RouteConfig(MySavedPostsRoute.name, path: '/my-saved-posts-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-screen');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.AuthScreen]
class AuthRoute extends _i6.PageRouteInfo<void> {
  const AuthRoute() : super(AuthRoute.name, path: '/auth-screen');

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i4.RegisterScreen]
class RegisterRoute extends _i6.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: '/register-screen');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.MySavedPostsScreen]
class MySavedPostsRoute extends _i6.PageRouteInfo<void> {
  const MySavedPostsRoute()
      : super(MySavedPostsRoute.name, path: '/my-saved-posts-screen');

  static const String name = 'MySavedPostsRoute';
}

import 'package:flutter/material.dart';
import 'package:usp_ecard/core/routes/app_routes.dart';
import 'package:usp_ecard/ui/pages/home/home_page.dart';
import 'package:usp_ecard/ui/pages/profile/profile_page.dart';

class AppRouter {
  AppRouter._();

  static MaterialPageRoute<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments as Map<String, dynamic>?;

    late final Widget page;

    switch (routeSettings.name) {
      case AppRoutes.home:
        page = const HomePage();
        break;
      case AppRoutes.profile:
        page = const ProfilePage();
        break;
      default:
        page = Container();
    }
    return MaterialPageRoute(
      builder: (_) => page,
      settings: routeSettings,
    );
  }
}

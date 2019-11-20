import 'package:astrologer/ui/view/home_view.dart';
import 'package:astrologer/ui/view/login_view.dart';
import 'package:astrologer/ui/view/profile_view.dart';
import 'package:astrologer/ui/shared/route_paths.dart';
import 'package:astrologer/ui/shared/theme_stream.dart';
import 'package:astrologer/ui/view/sign_up_view.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(
      RouteSettings settings, ThemeStream themeStream) {
    switch (settings.name) {
      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.signup:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case RoutePaths.home:
        return MaterialPageRoute(
            builder: (_) => HomeView(themeStream: themeStream));
      case RoutePaths.profile:
        return MaterialPageRoute(
            builder: (_) => ProfileView(themeStream: themeStream));
      case RoutePaths.example:
//        return MaterialPageRoute(builder: (_) => DashboardView2());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
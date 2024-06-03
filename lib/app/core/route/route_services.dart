import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/route/route_paths.dart';
import 'package:flutter_assessment/app/modules/home/view/home_page.dart';
import 'package:flutter_assessment/app/modules/login/view/login_page.dart';
import 'package:flutter_assessment/app/modules/main/view/main_view.dart';
import 'package:flutter_assessment/app/modules/setting/view/setting_page.dart';
import 'package:flutter_assessment/app/modules/signup/view/signup_page.dart';

class RouteServices {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutePaths.loginPage:
        return NoAnimationPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      case RoutePaths.signupPage:
        return NoAnimationPageRoute(
          builder: (_) => const SignupPage(),
          settings: settings,
        );

      case RoutePaths.homePage:
        return NoAnimationPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );

      case RoutePaths.mainPage:
        return NoAnimationPageRoute(
          builder: (_) => const MainView(),
          settings: settings,
        );

      case RoutePaths.settingPage:
        return NoAnimationPageRoute(
          builder: (_) => const SettingPage(),
          settings: settings,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Page Not Found"),
        ),
      );
    });
  }
}

class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute(
      {required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

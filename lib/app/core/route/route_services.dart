import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/route/route_paths.dart';
import 'package:flutter_assessment/app/modules/home/view/home_page.dart';
import 'package:flutter_assessment/app/modules/login/view/login_page.dart';
import 'package:flutter_assessment/app/modules/main/view/main_view.dart';
import 'package:flutter_assessment/app/modules/setting/view/setting_page.dart';
import 'package:flutter_assessment/app/modules/signup/view/signup_page.dart';
import 'package:go_router/go_router.dart';

class RouterService {
  bool userIsNotLoggedIn = false;

  static final router = GoRouter(
    initialLocation: '/setting',
    routes: [
      GoRoute(
        path: RoutePaths.loginPage,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.signupPage,
        builder: (context, state) => SignupPage(),
      ),
      GoRoute(
        path: RoutePaths.mainPage,
        builder: (context, state) => MainView(),
      ),
      GoRoute(
        path: RoutePaths.homePage,
        builder: (context, state) => HomePage(),
        // redirect: (context, state) {
        //   final routerService = RouterService();
        //   if (routerService.userIsNotLoggedIn) {
        //     return "/login";
        //   }
        //   return "/";
        // },
      ),
      GoRoute(
        path: RoutePaths.settingPage,
        builder: (context, state) => SettingPage(),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Error Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go("/"),
          child: const Text("Go to home page"),
        ),
      ),
    );
  }
}

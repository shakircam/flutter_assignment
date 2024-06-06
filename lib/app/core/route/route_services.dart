import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/route/route_paths.dart';
import 'package:flutter_assessment/app/core/services/service_locator.dart';
import 'package:flutter_assessment/app/data/local/preference/pref_manager.dart';
import 'package:flutter_assessment/app/modules/home/view/home_page.dart';
import 'package:flutter_assessment/app/modules/login/view/login_page.dart';
import 'package:flutter_assessment/app/modules/main/view/main_view.dart';
import 'package:flutter_assessment/app/modules/setting/view/setting_page.dart';
import 'package:flutter_assessment/app/modules/signup/view/signup_page.dart';
import 'package:flutter_assessment/app/utils/constants.dart';
import 'package:go_router/go_router.dart';

class RouterService {
  final PrefManager _local = serviceLocator<PrefManager>();

  Future<bool> isLoggedIn() async {
    String? token = await _local.getString(APP_TOKEN);
    return token != null && token.isNotEmpty;
  }

  static final router = GoRouter(
    initialLocation: '/',
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
        redirect: (context, state) async {
          final routerService = RouterService();
          if (await routerService.isLoggedIn()) {
            log("isLogged in");
            return null;
          }
          return RoutePaths
              .loginPage; // Redirect to login page if user is not logged in
        },
      ),
      GoRoute(
        path: RoutePaths.homePage,
        builder: (context, state) => HomePage(),
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

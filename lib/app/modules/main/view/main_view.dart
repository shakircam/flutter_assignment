import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/modules/cart/view/cart_page.dart';
import 'package:flutter_assessment/app/modules/home/view/home_page.dart';
import 'package:flutter_assessment/app/modules/main/controller/bottom_nav_controller.dart';
import 'package:flutter_assessment/app/modules/main/model/menu_code.dart';
import 'package:flutter_assessment/app/modules/more/more.dart';
import 'package:flutter_assessment/app/modules/setting/view/setting_page.dart';
import 'package:provider/provider.dart';
import 'bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    var navController = Provider.of<BottomNavController>(context, listen: true);
    return Scaffold(
      extendBody: true,
      body: getPageOnSelectedMenu(navController.selectedMenuCode),
      bottomNavigationBar:
          BottomNavBar(onNewMenuSelected: navController.onMenuSelected),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.bottomItemSelectedColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.search),
      ),
    );
  }

  Widget getPageOnSelectedMenu(MenuCode menuCode) {
    switch (menuCode) {
      case MenuCode.HOME:
        return const HomePage();
      case MenuCode.SETTING:
        return const SettingPage();
      case MenuCode.CART:
        return const CartPage();
      case MenuCode.MORE:
        return const MorePage();
      default:
        return const CartPage();
    }
  }
}

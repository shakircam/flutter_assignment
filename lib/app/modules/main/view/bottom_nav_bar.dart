import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_icons.dart';
import 'package:flutter_assessment/app/core/values/app_values.dart';
import 'package:flutter_assessment/app/core/widget/button/ripple.dart';
import 'package:flutter_assessment/app/core/widget/image/asset_image_view.dart';
import 'package:flutter_assessment/app/modules/main/controller/bottom_nav_controller.dart';
import 'package:flutter_assessment/app/modules/main/model/bottom_nav_item.dart';
import 'package:flutter_assessment/app/modules/main/model/menu_code.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  final Function(MenuCode menuCode) onNewMenuSelected;
  const BottomNavBar({Key? key, required this.onNewMenuSelected})
      : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final Key bottomNavKey = GlobalKey();

  final Color _selectedItemColor = AppColors.bottomItemSelectedColor;
  @override
  Widget build(BuildContext context) {
    List<BottomNavItem> navItems = _getNavItemsData();
    var navIndex = Provider.of<BottomNavController>(context, listen: true);

    return Container(
        //decoration: _getDecoration(context),
        margin: EdgeInsets.zero,
        child: BottomAppBar(
            notchMargin: 5.0,
            shape: const CircularNotchedRectangle(),
            child:
                _bottomAppBarItems(context, navItems, navIndex.selectedIndex)));
  }

  Widget _bottomAppBarItems(
      BuildContext context, List<BottomNavItem> navItems, int selectedIndex) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: navItems.map(
          (BottomNavItem navItem) {
            int index = navItems.indexOf(navItem);
            bool isSelectedItem = index == selectedIndex;

            return Ripple(
              onTap: () => _onTapNavItem(index, navItems[index]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  navItem.isIconFromIconData
                      ? _getNavItemIconFromIconData(navItem, isSelectedItem)
                      : _getNavItemIconFromAsset(
                          context, navItem, isSelectedItem),
                  Text(
                    navItem.navTitle,
                    style: TextStyle(
                        color: isSelectedItem
                            ? _selectedItemColor
                            : AppColors.bottomIcon),
                  ),
                ],
              ),
            );
          },
        ).toList());
  }

  Widget _getNavItemIconFromIconData(
    BottomNavItem navItem,
    bool isSelectedItem,
  ) {
    return Icon(
      isSelectedItem ? navItem.activeIconData : navItem.regularIconData,
      size: AppValues.iconDefaultSize.r,
      color: isSelectedItem ? _selectedItemColor : AppColors.bottomIcon,
    );
  }

  Widget _getNavItemIconFromAsset(
    BuildContext context,
    BottomNavItem navItem,
    bool isSelectedItem,
  ) {
    return AssetImageView(
      fileName:
          isSelectedItem ? navItem.activeAssetIcon : navItem.regularAssetIcon,
      height: AppValues.iconDefaultSize.r,
      width: AppValues.iconDefaultSize.r,
      color: isSelectedItem ? _selectedItemColor : AppColors.bottomIcon,
    );
  }

  void _onTapNavItem(
    int index,
    BottomNavItem navItem,
  ) {
    Provider.of<BottomNavController>(context, listen: false)
        .onIndexChanged(index);
    widget.onNewMenuSelected(navItem.menuCode);
  }

  List<BottomNavItem> _getNavItemsData() {
    return [
      BottomNavItem.fromAsset(
        navTitle: "Home",
        activeIcon: AppIcons.homeIcon,
        regularIcon: AppIcons.homeIcon,
        menuCode: MenuCode.HOME,
      ),
      BottomNavItem.fromAsset(
        navTitle: "More",
        activeIcon: AppIcons.moreIcon,
        regularIcon: AppIcons.moreIcon,
        menuCode: MenuCode.MORE,
      ),
      BottomNavItem.fromAsset(
        navTitle: "Cart",
        activeIcon: AppIcons.cartIcon,
        regularIcon: AppIcons.cartIcon,
        menuCode: MenuCode.CART,
      ),
      BottomNavItem.fromAsset(
        navTitle: "Setting",
        activeIcon: AppIcons.accountIcon,
        regularIcon: AppIcons.accountIcon,
        menuCode: MenuCode.SETTING,
      ),
    ];
  }

  BoxDecoration _getDecoration(BuildContext context) => BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withAlpha(140),
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              0.0,
              -5.0,
            ),
          )
        ],
        color: Theme.of(context).bottomAppBarTheme.color,
      );
}

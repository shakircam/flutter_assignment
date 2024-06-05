import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/core/values/app_colors.dart';
import 'package:flutter_assessment/app/core/values/app_values.dart';
import 'package:flutter_assessment/app/core/values/text_style.dart';
import 'package:flutter_assessment/app/core/widget/button/gradient_button.dart';
import 'package:flutter_assessment/app/core/widget/button/ripple.dart';
import 'package:flutter_assessment/app/modules/home/controller/home_controller.dart';
import 'package:flutter_assessment/app/modules/home/model/product_item.dart';
import 'package:flutter_assessment/app/modules/home/widget/product_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: const Text(
            'Product List',
            style: TextStyle(color: AppColors.almostBlack),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.colorBlack),
              onPressed: () {
                // Add search functionality here
              },
            ),
          ],
        ),
        body: Consumer<HomeController>(
          builder: (context, controller, child) {
            if (controller.filteredProducts.isEmpty) {
              controller.loadProducts();
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      children: [
                        TextButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    _filterBottomSheetContent(controller),
                              );
                            },
                            icon: const Icon(Icons.filter_list,
                                color: AppColors.neutralGray),
                            label: const Text(
                              'Filter',
                              style: TextStyle(color: AppColors.neutralGray),
                            )),
                        const Spacer(),
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.filter_list,
                                color: AppColors.neutralGray),
                            label: const Text(
                              'Sort by',
                              style: TextStyle(color: AppColors.neutralGray),
                            )),
                        IconButton(
                          icon: const Icon(
                            Icons.view_list,
                            color: AppColors.almostBlack,
                          ),
                          onPressed: () {
                            // Add view toggle functionality here
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                _buildProductList(context, controller)
              ],
            );
          },
        ));
  }

  Widget _buildProductList(BuildContext context, HomeController controller) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          return ProductCard(product: controller.filteredProducts[index]);
        },
      ),
    );
  }

  Widget _filterBottomSheetContent(HomeController controller) {
    String selectedFilter = '';

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.bottomSheetColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(children: [
          const Text(
            'Filter Products',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.colorBlack),
          ),
          const Divider(
            color: AppColors.checkboxColor,
          ),
          Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  side: const BorderSide(color: AppColors.checkboxColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: const BorderSide(color: AppColors.checkboxColor),
                  ),
                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors
                          .checkboxColor; // Selected background color
                    }
                    return AppColors
                        .transparent; // Transparent background color when unselected
                  }),
                  checkColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors
                          .white; // White check mark color when selected
                    }
                    return AppColors
                        .primary600; // Red stroke color when unselected
                  }),
                  overlayColor:
                      WidgetStateProperty.all<Color>(Colors.transparent),
                ),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Newest',
                        style: TextStyle(color: AppColors.colorBlack)),
                    value: selectedFilter == 'newest',
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value! ? 'newest' : '';
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Oldest',
                        style: TextStyle(color: AppColors.colorBlack)),
                    value: selectedFilter == 'oldest',
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value! ? 'oldest' : '';
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Price Low > High',
                        style: TextStyle(color: AppColors.colorBlack)),
                    value: selectedFilter == 'priceLowToHigh',
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value! ? 'priceLowToHigh' : '';
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Price High > Low',
                        style: TextStyle(color: AppColors.colorBlack)),
                    value: selectedFilter == 'priceHighToLow',
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value! ? 'priceHighToLow' : '';
                      });
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: _cancelButton()),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GradientButton(
                            buttonText: "Apply",
                            onTap: () {
                              switch (selectedFilter) {
                                case 'newest':
                                  controller.sortByNewest();
                                  break;
                                case 'oldest':
                                  controller.sortByOldest();
                                  break;
                                case 'priceLowToHigh':
                                  controller.sortByPriceLowToHigh();
                                  break;
                                case 'priceHighToLow':
                                  controller.sortByPriceHighToLow();
                                  break;
                              }
                              Navigator.pop(context);
                            }),
                      ),
                    ],
                  ),
                ],
              )),
        ]),
      );
    });
  }

  Widget _cancelButton() => Container(
        constraints: BoxConstraints(
          maxWidth: AppValues.maxButtonWidth.w,
          maxHeight: AppValues.maxButtonHeight.h,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius:
                const BorderRadius.all(Radius.circular(AppValues.radius_8)),
            color: AppColors.white),
        child: Ripple(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppValues.smallPadding.h,
              horizontal: AppValues.padding.w,
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.colorBlack),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}

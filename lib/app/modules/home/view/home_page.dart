import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/modules/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

enum SortOption { byStars, byUpdate }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomeController>(context, listen: true);

    return Scaffold(appBar: _homeAppBar(), body: _listView(controller));
  }

  Widget _listView(HomeController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: 1,
              controller: scrollController,
              itemBuilder: (_, index) {}),
        ),
      ],
    );
  }

  PreferredSizeWidget _homeAppBar() {
    return AppBar(
      title: const Text("Home"),
    );
  }
}

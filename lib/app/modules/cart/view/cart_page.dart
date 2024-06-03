import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final String viewParam;
  const CartPage({this.viewParam = ""});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'OtherView',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

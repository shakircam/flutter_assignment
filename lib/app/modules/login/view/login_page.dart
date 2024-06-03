import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final String viewParam;
  const LoginPage({this.viewParam = ""});

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

import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  final String viewParam;
  const SignupPage({this.viewParam = ""});

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

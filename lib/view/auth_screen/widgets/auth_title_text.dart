import 'package:flutter/material.dart';

class AuthTitleText extends StatelessWidget {
  final String text;

  const AuthTitleText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
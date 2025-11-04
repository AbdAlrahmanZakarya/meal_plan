
import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class AuthDescriptionText extends StatelessWidget {
  final String text;

  const AuthDescriptionText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: AppColors.black.withOpacity(0.64),
      ),
    );
  }
}

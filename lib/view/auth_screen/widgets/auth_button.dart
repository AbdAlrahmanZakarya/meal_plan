import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: AppColors.backgroundColor, boxShadow: [
        BoxShadow(
          color: AppColors.gray.withOpacity(0.1),
          offset: const Offset(0, -0.1),
          blurRadius: 12,
        )
      ]),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
           onPressed == null? Colors.grey : AppColors.primaryColor,
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
        ),
      ),
    );
  }
}

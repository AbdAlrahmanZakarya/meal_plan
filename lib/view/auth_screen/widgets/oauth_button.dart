import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';

class OAuthButton extends StatelessWidget {
  final String text;
  final String icon;
  final void Function() onPressed;
  final bool isGoogleBtn;
  const OAuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isGoogleBtn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.white),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 14),
          width: 500,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 2.5.h,
                // height: 2.h,
              ),
              const SizedBox(width: 18),
              Text(
                text,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: isGoogleBtn
                          ? const Color(0xFF4285F4)
                          : AppColors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

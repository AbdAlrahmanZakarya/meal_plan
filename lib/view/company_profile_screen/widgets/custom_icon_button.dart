import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/colors.dart';

class CustomIconButton extends StatelessWidget {
  final String imageUrl;
  final void Function()? onPressed;
  const CustomIconButton({Key? key, required this.imageUrl, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // margin: const EdgeInsets.only(left: 20),
      // padding: const EdgeInsets.only(right: 4),
      width: 43,
      height: 43,
      decoration: const BoxDecoration(
        color: AppColors.lightGray,
        shape: BoxShape.circle,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: SvgPicture.asset(
          imageUrl,
        ),
      ),
    );
  }
}

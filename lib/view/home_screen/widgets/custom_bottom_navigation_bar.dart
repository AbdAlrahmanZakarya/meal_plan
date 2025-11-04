import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  final void Function(int) onValueChanged;

  const CustomBottomNavBar({
    super.key,
    required this.onValueChanged,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: padding),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(0, -8),
            blurRadius: 16,
          )
        ],
      ),
      height: 70 + padding,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavIcon(0, 'assets/icons/home.svg'),
          buildNavIcon(1, 'assets/icons/favorite.svg'),
          buildNavIcon(2, 'assets/icons/profile.svg'),
        ],
      ),
    );
  }

  Widget buildNavIcon(int index, String imageUrl) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPage = index;
        });
        widget.onValueChanged(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: index == selectedPage
              ? AppColors.primaryColor
              : AppColors.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          imageUrl,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            index == selectedPage ? AppColors.white : AppColors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

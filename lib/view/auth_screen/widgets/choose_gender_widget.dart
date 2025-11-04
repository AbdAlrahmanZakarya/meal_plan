
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/colors.dart';

class ChooseGenderWidget extends StatefulWidget {
  final void Function(String val) onTap;

  const ChooseGenderWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  State<ChooseGenderWidget> createState() => _ChooseGenderWidgetState();
}

class _ChooseGenderWidgetState extends State<ChooseGenderWidget> {
  var selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildGenderItem('Male'),
        const SizedBox(width: 16),
        buildGenderItem('Female'),
      ],
    );
  }

  Widget buildGenderItem(String gender) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onTap(gender);
          setState(() {
            selectedGender = gender;
          });
        },
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: selectedGender == gender
                ? const Color(0x142C64FF)
                : AppColors.white,
            border: selectedGender == gender
                ? Border.all(
              color: const Color(0xFF2C64FF),
              width: 2,
            )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/$gender.svg'),
              const SizedBox(width: 8),
              Text(
                gender,
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

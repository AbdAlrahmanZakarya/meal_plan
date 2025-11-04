import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/colors.dart';

class SlidingSegmentedControlWidget extends StatefulWidget {
  final String tab1Text;
  final String tab2Text;
  final bool withIcon;
  final double borderRadius;
  final double innerBorderRadius;
  final void Function(int?) onValueChanged;

  const SlidingSegmentedControlWidget({
    Key? key,
    required this.onValueChanged,
    required this.tab1Text,
    required this.tab2Text,
    this.withIcon = false,
    this.borderRadius = 4,
    this.innerBorderRadius = 4,
  }) : super(key: key);

  @override
  State<SlidingSegmentedControlWidget> createState() =>
      _SlidingSegmentedControlWidgetState();
}

class _SlidingSegmentedControlWidgetState
    extends State<SlidingSegmentedControlWidget> {
  int groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: CustomSlidingSegmentedControl<int>(
        // fromMax: true,
        isStretch: true,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        thumbDecoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(widget.innerBorderRadius),
        ),
        innerPadding: const EdgeInsets.all(8),
        children: {
          0: buildSegment(0, widget.tab1Text),
          1: buildSegment(1, widget.tab2Text),
        },
        onValueChanged: (val) {
          widget.onValueChanged(val);
          setState(() {
            groupValue = val;
          });
        },
      ),

      // CupertinoSlidingSegmentedControl<int>(
      //   thumbColor: AppColors.primaryColor,
      //   backgroundColor: AppColors.primaryColor.withOpacity(0.08),
      //   groupValue: groupValue,
      //   padding: const EdgeInsets.all(8),
      //   children: {
      //     0: buildSegment(0, widget.tab1Text),
      //     1: buildSegment(1, widget.tab2Text),
      //   },
      //   onValueChanged: (val) {
      //     widget.onValueChanged(val);
      //     setState(() {
      //       groupValue = val!;
      //     });
      //   },
      //
      //   //     (val) {
      //   //   setState(() {
      //   //     groupValue = val!;
      //   //   });
      //   //   if (val == 0) {
      //   //     _controller.animateTo(0);
      //   //   } else if (val == 1) {
      //   //     _controller.animateTo(1);
      //   //   }
      //   // },
      // ),
    );
  }

  Widget buildSegment(int index, String text) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: widget.withIcon && index == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Flame.svg',
                  colorFilter: ColorFilter.mode(
                      groupValue == index
                          ? AppColors.white
                          : AppColors.black.withOpacity(0.56),
                      BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    text,
                    // overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontFamily: widget.withIcon ? 'Roboto' : null,
                          color: groupValue == index
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.56),
                          fontWeight: widget.withIcon
                              ? FontWeight.w500
                              : groupValue == index
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                        ),
                  ),
                ),
              ],
            )
          : Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: groupValue == index
                        ? AppColors.white
                        : AppColors.black.withOpacity(0.56),
                    fontWeight:
                        groupValue == index ? FontWeight.w600 : FontWeight.w500,
                  ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/colors.dart';
import '../../../data/models/profile_list_tile_model.dart';

class ProfileListItem extends StatelessWidget {
  final ProfileListTileModel listItem;

  const ProfileListItem({Key? key, required this.listItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      width: double.infinity,
      height: 67,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () {
            listItem.onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              right: 16,
              top: 10,
              left: 8,
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: listItem.imageBackgroundColor ??
                        AppColors.primaryColor.withOpacity(0.16),
                  ),
                  child:
                      SvgPicture.asset('assets/icons/${listItem.imageUrl}'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        listItem.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      if (listItem.description != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          listItem.description!,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ],
                  ),
                ),
                SvgPicture.asset('assets/icons/arrow.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

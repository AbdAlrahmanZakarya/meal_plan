
import 'package:flutter/material.dart';

import 'widgets/featured_plans_card.dart';

class FeaturesPlansListView extends StatelessWidget {
  const FeaturesPlansListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 14, top: 12, bottom: 12),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(5, (index) => const FeaturesPlansCard()),
            ),
          ),
        ],
      ),
    );
  }
}

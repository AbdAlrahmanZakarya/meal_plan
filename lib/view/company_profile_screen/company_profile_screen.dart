import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../data/models/company_model.dart';
import '../shared_widget/bottom_company_info_bar.dart';
import '../shared_widget/sliding_segmented_control_widget.dart';
import 'company_plans_tab_bar_view.dart';
import 'widgets/custom_icon_button.dart';
import 'features_plans_list_view.dart';

class CompanyProfileScreen extends StatefulWidget {
  final CompanyModel company;

  const CompanyProfileScreen({Key? key, required this.company})
      : super(key: key);

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  late ScrollController scrollController;
  bool silverCollapsed = false;
  int currentPage = 0;
  String title = '';

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();

    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.offset > 220 &&
          !scrollController.position.outOfRange) {
        if (!silverCollapsed) {
          // do what ever you want when silver is collapsing !
          print('silver is collapsing ${scrollController.offset}');

          title = widget.company.companyName;
          silverCollapsed = true;
          setState(() {});
        }
      }
      if (scrollController.offset <= 220 &&
          !scrollController.position.outOfRange) {
        if (silverCollapsed) {
          // do what ever you want when silver is expanding !
          print('silver is expanding ${scrollController.offset}');

          title = '';
          silverCollapsed = false;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomCompanyInfoBar(companyId: widget.company.id),
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (ctx, _) {
          return [
            buildSliverAppBar(context),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    child: Text(
                      'Company Plans',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                      bottom: 10,
                    ),
                    child: SlidingSegmentedControlWidget(
                      onValueChanged: (val) {
                        setState(() {
                          tabController.animateTo(val ?? 0);
                        });
                      },
                      tab1Text: 'Featured Plans',
                      tab2Text: 'See All',
                      withIcon: true,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            const FeaturesPlansListView(),
            CompanyPlansTabBarView(companyId: widget.company.id),
          ],
        ),
      ),
    );
  }

  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      expandedHeight: 296,
      leadingWidth: 70,
      leading: Align(
        alignment: Alignment.centerRight,
        child: CustomIconButton(
          imageUrl: 'assets/icons/arrow_left.svg',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        CustomIconButton(
          imageUrl: 'assets/icons/favorite-red.svg',
          onPressed: () {},
        ),
        const SizedBox(width: 24),
      ],
      flexibleSpace: buildAppBar(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return FlexibleSpaceBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 0,
            // child: Hero(
            //   tag: company.id,
            child: Image.network(
              widget.company.imageUrl,
              fit: BoxFit.cover,
            ),
            // ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 0,
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 128),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${widget.company.companyName} Company',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppColors.lightGray,
                      ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.company.description,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.lightGray,
                      ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // CustomIconButton(
                    //   imageUrl: 'assets/icons/Instagram.svg',
                    //   onPressed: () {},
                    // ),
                    // const SizedBox(width: 10),
                    // CustomIconButton(
                    //   imageUrl: 'assets/icons/twitter.svg',
                    //   onPressed: () {},
                    // ),
                    // const SizedBox(width: 10),
                    // CustomIconButton(
                    //   imageUrl: 'assets/icons/Browser.svg',
                    //   onPressed: () {},
                    // ),
                    // const SizedBox(width: 10),
                    ...widget.company.social.entries.map((e) {
                      var val = ['twitter', 'instagram', 'webSite'];
                      if (val.contains(e.key)) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: CustomIconButton(
                            imageUrl: 'assets/icons/${e.key}.svg',
                            onPressed: () {},
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                    // ...widget.company.social
                    //     .map(
                    //       (Social e) {
                    //         widget.company.social.any((element) => element.type.name == 'webSite') ; //   (element) => element.type.name == 'webSite');
                    //         e.type.name;
                    //         return Container();
                    //       },
                    //     )
                    //     .toList(),
                    //
                    if (widget.company.social['webSite'] != null)
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(),
                        child: Text(
                          widget.company.social['webSite']!,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 64,
                  height: 1.5,
                  color: const Color(0x8F707070),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

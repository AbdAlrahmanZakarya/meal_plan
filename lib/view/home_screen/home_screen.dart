import 'package:flutter/material.dart';

import 'widgets/custom_bottom_navigation_bar.dart';
import 'dashboard_page.dart';
import 'favorites_page.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        onValueChanged: _controller.animateTo,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: const [
          DashboardScreen(),
          FavoritesPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}

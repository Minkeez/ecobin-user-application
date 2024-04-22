import 'package:flutter/material.dart';
import 'package:user_application/leaderboard_screen.dart';
import 'package:user_application/point_screen.dart';
// import 'package:user_application/firestore_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar.secondary(
          controller: _tabController,
          tabs: const [
            Tab(text: 'point'),
            Tab(text: 'leaderboard'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              PointScreen(),
              LeaderboardScreen(),
            ],
          ),
        ),
      ],
    );
  }
}

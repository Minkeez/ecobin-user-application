import 'package:flutter/material.dart';
import 'package:user_application/redeem_screen.dart';
import 'package:user_application/news_screen.dart';
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
            Tab(text: 'News'),
            Tab(text: 'Redeem'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              NewsScreen(),
              // Center(
              //   child: Text("Placeholder for reward screen later"),
              // ),
              RedeemScreen(),
            ],
          ),
        ),
      ],
    );
  }
}

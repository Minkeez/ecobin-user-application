import 'package:flutter/material.dart';

void main() {
  runApp(const EcoBin());
}

class EcoBin extends StatelessWidget {
  const EcoBin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const EcoBinHome(),
    );
  }
}

class EcoBinHome extends StatelessWidget {
  const EcoBinHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(''),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Scan',
                icon: Icon(Icons.qr_code),
              ),
              Tab(
                text: 'Home',
                icon: Icon(Icons.home),
              ),
              Tab(
                text: 'Profile',
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NestedTabBar('Home'),
          ],
        ),
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
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
              Card(
                margin: EdgeInsets.all(16),
                child: Center(
                  child: Text('overview point'),
                ),
              ),
              Card(
                margin: EdgeInsets.all(16),
                child: Center(
                  child: Text('leaderboard'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

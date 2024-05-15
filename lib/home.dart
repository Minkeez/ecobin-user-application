import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'qrcode_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index == 0 && mounted) {
        Future.delayed(Duration.zero, () {
          if (mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const QRCodeScreen()),
            );
            _tabController.animateTo(1,
                duration: const Duration(milliseconds: 300));
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 55, 179),
        title: const Text(''),
        bottom: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          tabs: const [
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
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(),
          // const Center(
          //   child: Text('QR Code Scanner Placeholder'),
          // ),
          const HomeScreen('Home'),
          ProfileScreen(
            nameController: _nameController,
            phoneController: _phoneController,
          ),
        ],
      ),
    );
  }
}

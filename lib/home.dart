import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 41, 55, 179),
          title: const Text(''),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            labelColor: Colors.white,
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
        body: TabBarView(
          children: [
            const Center(
              child: Text('QR Code Scanner Placeholder'),
            ),
            const HomeScreen('Home'),
            ProfileScreen(
              nameController: _nameController,
              phoneController: _phoneController,
            ),
          ],
        ),
      ),
    );
  }
}

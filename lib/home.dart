import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
        body: const TabBarView(
          children: [
            Center(
              child: Text('QR Code Scanner Placeholder'),
            ),
            HomeScreen('Home'),
            ProfileScreen(),
            // Center(
            //   child: Text('Profile View Placeholder'),
            // ),
          ],
        ),
      ),
    );
  }
}

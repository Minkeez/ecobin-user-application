import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_application/leaderboard_section.dart';
import 'package:user_application/point_section.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'change_phone_number_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.nameController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (widget.phoneController.text.isNotEmpty) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.phoneController.text)
          .get();

      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data();
        });
      }
    }
  }

  void _editPhoneNumber() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => ChangePhoneNumberScreen(
          phoneController: widget.phoneController,
        ),
      ),
    )
        .then((_) {
      setState(() {
        _fetchUserData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              const ProfileHeader(),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    ProfileInfo(
                      nameController: widget.nameController,
                      phoneController: widget.phoneController,
                      onPhoneEdit: _editPhoneNumber,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Total Point"),
          _buildSectionContent(
            userData != null
                ? PointSection(points: userData!['totalPoints'] ?? 0)
                : _buildPlaceholderContent(),
          ),
          _buildSectionTitle("Leaderboard"),
          _buildSectionContent(
            userData != null
                ? LeaderboardSection(
                    bottles: userData!['bottles'] ?? 0,
                    cans: userData!['cans'] ?? 0,
                    yogurtCups: userData!['yogurtCups'] ?? 0,
                  )
                : _buildPlaceholderContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 30),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionContent(Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(20, 41, 55, 179),
      ),
      child: child,
    );
  }

  Widget _buildPlaceholderContent() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        'Please enter phone number to view data...',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}

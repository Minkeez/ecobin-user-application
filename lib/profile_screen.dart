import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_application/leaderboard_screen.dart';

import 'point_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle errors or user cancellation here
      print('Image picker error: $e');
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Image display and picker button
          Row(
            children: [
              SizedBox(width: 20),
              Text("Test 1"),
              SizedBox(width: 20),
              Text("Test 2"),
            ],
          ),
          _image != null
              ? Image.file(_image!, width: 150, height: 150)
              : Container(
                  width: 150,
                  height: 150,
                  color: const Color.fromARGB(255, 41, 55, 179),
                  alignment: Alignment.center,
                  child: const Text(
                    'upload profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Choose Image'),
          ),
          const SizedBox(height: 20),
          // Phone number input field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          SizedBox(height: 20),
          Text("Point", style: TextStyle(fontWeight: FontWeight.bold),),
          PointScreen(),
          Text("Leaderboard", style: TextStyle(fontWeight: FontWeight.bold),),
          LeaderboardScreen(),
        ],
      ),
    );
  }
}
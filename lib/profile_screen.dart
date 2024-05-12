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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  _image != null
                      ? Image.file(
                          _image!,
                          width: 150,
                          height: 150,
                        )
                      : Container(
                          width: 150,
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 41, 55, 179),
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 104.0,
                          ),
                          //   child: const Text(
                          //     'upload profile',
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                        ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.white,
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // Phone number input field
              Expanded(
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 30),
            child: const Text(
              "Total Point",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  top: 5, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(20, 41, 55, 179),
              ),
              child: const PointScreen()),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 30),
            child: const Text(
              "Leaderboard",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            margin:
                const EdgeInsets.only(top: 5, bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(20, 41, 55, 179),
            ),
            child: const LeaderboardScreen(),
          ),
        ],
      ),
    );
  }
}

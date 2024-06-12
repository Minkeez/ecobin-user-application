import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        await _saveProfileImage(pickedFile.path);
      }
    } catch (e) {
      // Handle errors or user cancellation here
      // ignore: avoid_print
      print('Image picker error: $e');
    }
  }

  Future<void> _saveProfileImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', imagePath);
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

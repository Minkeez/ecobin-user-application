import 'package:flutter/material.dart';
import 'package:user_application/leaderboard_section.dart';
import 'package:user_application/point_section.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'otp_verification_screen.dart';

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
  void _editPhoneNumber() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(
          phoneController: widget.phoneController,
        ),
      ),
    );
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
          _buildSectionContent(const PointSection()),
          _buildSectionTitle("Leaderboard"),
          _buildSectionContent(const LeaderboardSection()),
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
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import 'qrcode_screen.dart';
// import 'leaderboard_section.dart';
// import 'point_section.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen(
//       {super.key, required this.nameController, required this.phoneController});

//   final TextEditingController nameController;
//   final TextEditingController phoneController;

//   @override
//   // ignore: library_private_types_in_public_api
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   bool _isEditingName = false;
//   bool _isEditingPhone = false;

//   Future<void> _pickImage() async {
//     try {
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       // Handle errors or user cancellation here
//       print('Image picker error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 20),
//           // Image display and picker button
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(width: 20),
//               Stack(
//                 clipBehavior: Clip.none,
//                 alignment: Alignment.bottomRight,
//                 children: [
//                   _image != null
//                       ? Image.file(
//                           _image!,
//                           width: 150,
//                           height: 150,
//                         )
//                       : Container(
//                           width: 150,
//                           height: 150,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: const Color.fromARGB(255, 41, 55, 179),
//                           ),
//                           child: const Icon(
//                             Icons.account_circle,
//                             color: Colors.white,
//                             size: 104.0,
//                           ),
//                         ),
//                   Positioned(
//                     right: 0,
//                     bottom: 0,
//                     child: IconButton(
//                       icon: const Icon(Icons.add_a_photo),
//                       color: Colors.white,
//                       onPressed: _pickImage,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 20),
//               // Phone number input field
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: 10),
//                     _buildProfileInfo(
//                         "Name", widget.nameController, _isEditingName, () {
//                       setState(() {
//                         _isEditingName = !_isEditingName;
//                       });
//                     }),
//                     _buildProfileInfo(
//                         "Phone number", widget.phoneController, _isEditingPhone,
//                         () {
//                       setState(() {
//                         _isEditingPhone = !_isEditingPhone;
//                       });
//                     }),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 20),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.only(left: 30),
//             child: const Text(
//               "Total Point",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Container(
//               width: double.infinity,
//               margin: const EdgeInsets.only(
//                   top: 5, bottom: 20, left: 20, right: 20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: const Color.fromARGB(20, 41, 55, 179),
//               ),
//               child: const PointSection()),
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.only(left: 30),
//             child: const Text(
//               "Leaderboard",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             margin:
//                 const EdgeInsets.only(top: 5, bottom: 20, left: 20, right: 20),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: const Color.fromARGB(20, 41, 55, 179),
//             ),
//             child: const LeaderboardSection(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildProfileInfo(String label, TextEditingController controller,
//     bool isEditing, VoidCallback toggleEdit) {
//   if (isEditing) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           suffixIcon: IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: toggleEdit,
//           ),
//         ),
//         onSubmitted: (value) => toggleEdit(),
//       ),
//     );
//   } else {
//     return ListTile(
//       title: Text(
//         controller.text.isEmpty ? 'Enter $label' : controller.text,
//         style: const TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       subtitle: Text(
//         label,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Color.fromARGB(150, 41, 55, 179),
//         ),
//       ),
//       trailing: IconButton(
//         icon: const Icon(Icons.edit),
//         onPressed: toggleEdit,
//       ),
//       onTap: toggleEdit,
//     );
//   }
// }

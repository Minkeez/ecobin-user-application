import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.onPhoneEdit,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final VoidCallback onPhoneEdit;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  bool _isEditingName = false;

  @override
  void initState() {
    super.initState();
    _loadProfileInfo();
    widget.nameController.addListener(_saveName);
    widget.phoneController.addListener(_savePhoneNumber);

    // Add listener to phoneController to rebuild widget when phone number changes
    // widget.phoneController.addListener(_updatePhoneNumber);
  }

  @override
  void dispose() {
    // widget.phoneController.removeListener(_updatePhoneNumber);
    widget.nameController.removeListener(_saveName);
    widget.phoneController.removeListener(_savePhoneNumber);
    super.dispose();
  }

  Future<void> _loadProfileInfo() async {
    final prefs = await SharedPreferences.getInstance();
    widget.nameController.text = prefs.getString('user_name') ?? '';
    widget.phoneController.text = prefs.getString('phone_number') ?? '';
  }

  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', widget.nameController.text);
  }

  Future<void> _savePhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone_number', widget.phoneController.text);
  }

  // void _updatePhoneNumber() {
  //   setState(() {}); // Trigger a rebuild when the phone number changes
  // }

  void _toggleEditingName() {
    setState(() {
      _isEditingName = !_isEditingName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProfileInfo("Name", widget.nameController,
            isEditable: true,
            isEditing: _isEditingName,
            onEdit: _toggleEditingName),
        const SizedBox(height: 10),
        _buildProfileInfo(
          "Phone number",
          widget.phoneController,
          isEditable: false,
          onEdit: widget.onPhoneEdit,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildProfileInfo(
    String label,
    TextEditingController controller, {
    bool isEditable = true,
    bool isEditing = false,
    VoidCallback? onEdit,
  }) {
    return ListTile(
      title: isEditing
          ? TextField(
              controller: controller,
              decoration: InputDecoration(labelText: label),
              onSubmitted: (_) => onEdit?.call(),
            )
          : Text(
              controller.text.isEmpty ? 'Enter $label' : controller.text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
      subtitle: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(150, 41, 55, 179),
        ),
      ),
      trailing: isEditable
          ? IconButton(
              icon: Icon(isEditing ? Icons.check : Icons.edit),
              onPressed: onEdit,
            )
          : IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
      onTap: isEditable ? onEdit : null,
    );
  }
}

import 'package:flutter/material.dart';

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
              icon: Icon(isEditable ? Icons.check : Icons.edit),
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

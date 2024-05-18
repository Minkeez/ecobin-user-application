import 'package:flutter/material.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key, required this.phoneController});

  final TextEditingController phoneController;

  @override
  // ignore: library_private_types_in_public_api
  _ChangePhoneNumberScreenState createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  final TextEditingController _newPhoneController = TextEditingController();

  void _submitNewPhoneNumber() {
    setState(() {
      widget.phoneController.text = _newPhoneController.text;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Phone Number")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _newPhoneController,
              decoration: const InputDecoration(labelText: "New Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitNewPhoneNumber,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

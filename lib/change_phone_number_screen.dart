import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'otp_verification_screen.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key, required this.phoneController});

  final TextEditingController phoneController;

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  final TextEditingController _newPhoneController = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    // Prepopulate the phone number in the desired format
    final currentPhone = widget.phoneController.text;
    if (currentPhone.startsWith("0")) {
      _newPhoneController.text = currentPhone;
    }
  }

  void _submitNewPhoneNumber() {
    final phoneNumber = _newPhoneController.text;
    final regex = RegExp(r'^0\d{9}$');

    if (!regex.hasMatch(phoneNumber)) {
      setState(() {
        _errorText =
            'Please enter a valid phone number in the format 0XXXXXXXXX';
      });
    } else {
      setState(() {
        widget.phoneController.text = phoneNumber;
        _errorText = null;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OTPVerificationScreen(
            phoneNumber: phoneNumber,
            phoneController: widget.phoneController,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _newPhoneController.dispose();
    super.dispose();
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
              decoration: InputDecoration(
                labelText: "New Phone Number",
                errorText: _errorText,
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitNewPhoneNumber,
              child: const Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}

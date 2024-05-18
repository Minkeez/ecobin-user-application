import 'package:flutter/material.dart';
import 'change_phone_number_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key, required this.phoneController});

  final TextEditingController phoneController;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  void _submitOTP() {
    // Simulate OTP verification
    if (_otpController.text == "123456") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ChangePhoneNumberScreen(
            phoneController: widget.phoneController,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: "Enter OTP"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitOTP,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen(
      {super.key, required this.phoneNumber, required this.phoneController});

  final String phoneNumber;

  final TextEditingController phoneController;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  String? _errorText;

  void _verifyOTP() {
    final otp = _otpController.text;
    if (otp == '123456') {
      setState(() {
        _errorText = null;
      });
      widget.phoneController.text = widget.phoneNumber;
      Navigator.of(context).popUntil((route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Phone number ${widget.phoneNumber} updated successfully!",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    } else {
      setState(() {
        _errorText = "Invalid OTP. Please try again";
      });
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  // void _submitOTP() {
  //   // Simulate OTP verification
  //   if (_otpController.text == "123456") {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => ChangePhoneNumberScreen(
  //           phoneController: widget.phoneController,
  //         ),
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Invalid OTP")),
  //     );
  //   }
  // }

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
              decoration: InputDecoration(
                labelText: "Enter OTP",
                errorText: _errorText,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}

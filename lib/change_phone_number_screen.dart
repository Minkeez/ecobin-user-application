import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Prepopulate the phone number in the desired format
    final currentPhone = widget.phoneController.text;
    if (currentPhone.startsWith("0")) {
      _newPhoneController.text = currentPhone;
    }
  }

  void _submitNewPhoneNumber() async {
    final phoneNumber = _newPhoneController.text;
    final regex = RegExp(r'^0\d{9}$');

    if (!regex.hasMatch(phoneNumber)) {
      setState(() {
        _errorText =
            'Please enter a valid phone number in the format 0XXXXXXXXX';
      });
    } else {
      setState(() {
        // widget.phoneController.text = phoneNumber;
        _errorText = null;
      });

      await _auth.verifyPhoneNumber(
        phoneNumber: "+66${phoneNumber.substring(1)}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-sign in if verification completed
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _errorText = e.message;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OTPVerificationScreen(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
                phoneController: widget.phoneController,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
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
      appBar: AppBar(
        title: const Text("Change Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your phone number",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Icon(
              Icons.phone_android,
              size: 100,
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _newPhoneController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                errorText: _errorText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "We will send you one time password (OTP)",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _submitNewPhoneNumber,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromARGB(255, 41, 55, 179),
              ),
              child: const Text(
                "Send OTP",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

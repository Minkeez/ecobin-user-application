import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.phoneController,
  });

  final String phoneNumber;
  final String verificationId;
  final TextEditingController phoneController;

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  String? _errorText;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isResending = false;
  late String _verificationId;

  @override
  void initState() {
    super.initState();
    _verificationId = widget.verificationId;
  }

  void _verifyOTP() async {
    final otp = _otpController.text;
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);

      setState(() {
        _errorText = null;
      });

      // Save the phone number to Firestore
      await _firestore.collection('Users').doc(widget.phoneNumber).set({
        'totalPoints': 0,
        'bottles': 0,
        'cans': 0,
        'yogurtCups': 0,
        'userName': widget.phoneNumber,
      });

      widget.phoneController.text = widget.phoneNumber;
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
      // ignore: use_build_context_synchronously
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
    } catch (e) {
      setState(() {
        _errorText = "Invalid OTP. Please try again.";
      });
    }
  }

  void _resendOTP() async {
    setState(() {
      _isResending = true;
    });
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+66${widget.phoneNumber.substring(1)}",
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _errorText = e.message;
            _isResending = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _errorText = null;
            _isResending = false;
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      setState(() {
        _errorText = "Failed to resend OTP. Please try again";
        _isResending = false;
      });
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.security,
              size: 100,
              color: Color.fromARGB(255, 41, 55, 179),
            ),
            const SizedBox(height: 20),
            const Text(
              "We have sent OTP\non your phone number",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Pinput(
              controller: _otpController,
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onCompleted: (pin) => _verifyOTP(),
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _verifyOTP,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromARGB(255, 41, 55, 179),
              ),
              child: const Text(
                "> Next",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive OTP ?"),
                TextButton(
                  onPressed: _isResending ? null : _resendOTP,
                  child: const Text("Resend OTP"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

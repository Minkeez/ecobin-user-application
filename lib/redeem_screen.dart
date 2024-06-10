import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RedeemScreen extends StatefulWidget {
  const RedeemScreen({super.key});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> _fetchUserPoints() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc =
          await _firestore.collection('Users').doc(user.phoneNumber).get();
      if (userDoc.exists) {
        return userDoc.data()?['totalPoints'] ?? 0;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _fetchUserPoints(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching points'));
        } else {
          int points = snapshot.data ?? 0;
          return Column(
            children: [
              // Points and Donate button section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Points: $points',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 41, 55, 179),
                      ),
                      child: const Text(
                        'Donate',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Redeem Point label
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12.0),
                padding: const EdgeInsets.all(16.0),
                color: const Color.fromARGB(255, 41, 55, 179),
                child: const Center(
                  child: Text(
                    "Redeem Point",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Scrollable item list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: 5, // Assume we have 10 items for now
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 41, 55, 179)),
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Handle item click
                        },
                        child: const Row(
                          children: [
                            // Dummy item image
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.redeem,
                                size: 100,
                                color: Color.fromARGB(255, 41, 55, 179),
                              ),
                            ),
                            SizedBox(width: 50.0),
                            // Item description
                            Expanded(
                              child: Text(
                                'Reward that you can redeem it, thank you for save the world',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

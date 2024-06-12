import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _totalPoints = 0;

  int get totalPoints => _totalPoints;

  UserProvider() {
    _fetchUserPoints();
    _listenToUserPoints();
  }

  Future<void> _fetchUserPoints() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc =
          await _firestore.collection('Users').doc(user.phoneNumber).get();
      if (userDoc.exists) {
        _totalPoints = userDoc.data()?['totalPoints'] ?? 0;
        notifyListeners();
      }
    }
  }

  void _listenToUserPoints() {
    final user = _auth.currentUser;
    if (user != null) {
      _firestore
          .collection('Users')
          .doc(user.phoneNumber)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          _totalPoints = snapshot.data()?['totalPoints'] ?? 0;
          notifyListeners();
        }
      });
    }
  }
}

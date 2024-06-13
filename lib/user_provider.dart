import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _totalPoints = 0;
  String _name = '';
  String _phoneNumber = '';

  int get totalPoints => _totalPoints;
  String get name => _name;
  String get phoneNumber => _phoneNumber;

  UserProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _fetchUserDetails();
    _listenToUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc =
          await _firestore.collection('Users').doc(user.phoneNumber).get();
      if (userDoc.exists) {
        _totalPoints = userDoc.data()?['totalPoints'] ?? 0;
        _name = userDoc.data()?['userName'] ?? '';
        _phoneNumber = userDoc.data()?['phoneNumber'] ?? '';
        notifyListeners();
      }
    }
  }

  void _listenToUserDetails() {
    final user = _auth.currentUser;
    if (user != null) {
      _firestore
          .collection('Users')
          .doc(user.phoneNumber)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          _totalPoints = snapshot.data()?['totalPoints'] ?? 0;
          _name = snapshot.data()?['userName'] ?? '';
          _phoneNumber = snapshot.data()?['phoneNumber'] ?? '';
          notifyListeners();
        }
      });
    }
  }

  void updatePoints(int points) {
    final user = _auth.currentUser;
    if (user != null) {
      _firestore.collection('Users').doc(user.phoneNumber).update({
        'totalPoints': points,
      });
    }
  }

  void updateName(String name) {
    final user = _auth.currentUser;
    if (user != null) {
      _firestore.collection('Users').doc(user.phoneNumber).update({
        'userName': name,
      });
      _name = name;
      notifyListeners();
    }
  }
}

  // Future<void> _initialized() async {
  //   await _fetchUserPoints();
  //   _listenToUserPoints();
  // }

  // Future<void> _fetchUserPoints() async {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     final userDoc =
  //         await _firestore.collection('Users').doc(user.phoneNumber).get();
  //     if (userDoc.exists) {
  //       _totalPoints = userDoc.data()?['totalPoints'] ?? 0;
  //       notifyListeners();
  //     }
  //   }
  // }

  // void _listenToUserPoints() {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     _firestore
  //         .collection('Users')
  //         .doc(user.phoneNumber)
  //         .snapshots()
  //         .listen((snapshot) {
  //       if (snapshot.exists) {
  //         _totalPoints = snapshot.data()?['totalPoints'] ?? 0;
  //         notifyListeners();
  //       }
  //     });
  //   }
  // }

  // void updatePoints(int points) {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     _firestore.collection('Users').doc(user.phoneNumber).update({
  //       'totalPoints': points,
  //     });
  //   }
  // }
// }

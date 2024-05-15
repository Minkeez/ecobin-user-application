import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user_application/first_time_user.dart';
import 'home.dart';

/// Flutter code sample for [TabBar].

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await UserPreferences.init();
  bool firstTime = await UserPreferences.isFirstTime();
  runApp(EcoBin(isFirstTime: firstTime));
}

class EcoBin extends StatelessWidget {
  const EcoBin({super.key, required this.isFirstTime});

  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Home(),
    );
  }
}

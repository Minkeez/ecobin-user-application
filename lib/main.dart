import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'profile_screen.dart';
import 'user_preferences.dart';
import 'user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserPreferences.init();
  runApp(const EcoBin());
}

class EcoBin extends StatelessWidget {
  const EcoBin({super.key});

  Future<bool> _isFirstTimeUser() async {
    return UserPreferences.isFirstTimeUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFirstTimeUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final isFirstTimeUser = snapshot.data ?? true;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          home: isFirstTimeUser ? const FirstTimeProfileScreen() : const Home(),
        );

        // return MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(create: (_) => UserProvider()),
        //   ],
        //   child: MaterialApp(
        //     debugShowCheckedModeBanner: false,
        //     theme: ThemeData(useMaterial3: true),
        //     home:
        //         isFirstTimeUser ? const FirstTimeProfileScreen() : const Home(),
        //   ),
        // );
      },
    );
  }
}

class FirstTimeProfileScreen extends StatelessWidget {
  const FirstTimeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    return ProfileScreen(
      nameController: nameController,
      phoneController: phoneController,
    );
  }
}

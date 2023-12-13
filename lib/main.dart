import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resculpt/firebase_options.dart';
import 'package:resculpt/onboading_screen/onboarding_screen.dart';
import 'package:resculpt/screens/home.dart';
import 'package:resculpt/widgets/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Loading indicator or splash screen while checking auth state.
                return const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Loading(),
                );
              }
              if (snapshot.hasData) {
                return const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Home(),
                );
              } else {
                return const MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: OnboardingScreen(),
                );
              }
            },
          );
        }
        // Loading indicator or splash screen while initializing Firebase.
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Loading(),
        );
      },
    );
  }
}

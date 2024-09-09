


import 'package:fbsocial/adminscreen.dart' as admin;
import 'package:fbsocial/authentication/login.dart';
import 'package:fbsocial/authentication/signup.dart' as auth;
import 'package:fbsocial/facebooksign.dart';
import 'package:fbsocial/screens/company/company.dart';
import 'package:fbsocial/screens/splashScreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => FacebookSignInController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: _buildHomeScreen(),
      routes: {
        '/splashScreen': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/sign-up': (context) => auth.SignUpPage(), // Use the prefixed signup page
        '/company-homepage': (context) => CompanyHomePage(), // Use the prefixed signup page
      },
    );
  }

  Widget _buildHomeScreen() {
    return FutureBuilder<bool>(
      future: _checkAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen(); // Show splash screen while checking auth status
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final isLoggedIn = snapshot.data!;
          if (isLoggedIn) {
            return _buildUserHomePage();
          } else {
            return LoginPage(); // Redirect to login if not logged in
          }
        } else {
          return LoginPage(); // Default to login if no data
        }
      },
    );
  }

  Widget _buildUserHomePage() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getUserData(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen(); // Show splash screen while fetching user data
        } else if (userSnapshot.hasError) {
          return Center(child: Text('Error: ${userSnapshot.error}'));
        } else if (userSnapshot.hasData) {
          final userData = userSnapshot.data!;
          return admin.HomePage(); // Use the HomePage from adminscreen.dart
        } else {
          return LoginPage(); // Default to login if no data
        }
      },
    );
  }

  Future<bool> _checkAuthStatus() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return firebaseUser != null; // Return true if user is signed in with Firebase
  }

  Future<Map<String, dynamic>> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // You can fetch more user data from Firestore or your backend if needed
      return {
        'name': user.displayName ?? 'No Name',
        'email': user.email ?? 'No Email',
        'picture': user.photoURL,
      };
    }
    return {}; // Return an empty map if no user data
  }
}

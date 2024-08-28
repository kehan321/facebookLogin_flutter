// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class GoogleSignInController with ChangeNotifier {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   GoogleSignInAccount? googleSignInAccount;
//   bool _isLoading = false;

//   bool get isLoading => _isLoading;

//   Future<void> _signInWithGoogle(BuildContext context) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser == null) {
//         _isLoading = false;
//         notifyListeners();
//         return;
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final UserCredential userCredential =
//           await _firebaseAuth.signInWithCredential(credential);

//       if (userCredential.user != null) {
//         googleSignInAccount = googleUser;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Sign in successful with Google!'),
//           ),
//         );
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Sign in failed with Google.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('An unexpected error occurred: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       print("errror      $e");
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> login(BuildContext context) async {
//     await _signInWithGoogle(context);
//   }

//   Future<void> logout() async {
//     await _googleSignIn.signOut();
//     googleSignInAccount = null;
//     notifyListeners();
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// Future<void> _signInWithGoogle() async {
//   setState(() {
//     _isLoading = true;
//   });

//   try {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser == null) {
//       setState(() {
//         _isLoading = false;
//       });
//       return; // The user canceled the sign-in
//     }

//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     UserCredential userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Sign in successful with Google!'),
//       ),
//     );

//     // Navigate to the home page
//     Navigator.pushReplacementNamed(context, '/home');
//   } on FirebaseAuthException catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Sign in failed: ${e.message}'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   } finally {
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }

// import 'package:fbsocial/adminscreen.dart';
// import 'package:fbsocial/applesignin.dart';
// import 'package:fbsocial/facebooksign.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// // Import the home page

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   // final GoogleSignIn _googleSignIn = GoogleSignIn();
//   bool _isLoading = false;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final facebookSignInController =
//         Provider.of<FacebookSignInController>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//               ),
//               TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _signUpWithFirebase(
//                     emailController.text,
//                     passwordController.text,
//                   );
//                 },
//                 child: Text('Sign Up with Firebase'),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _signInWithGoogle();
        
//                 },
//                 child: Text('Sign Up with Google'),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   await facebookSignInController.login();
//                   if (facebookSignInController.userData != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             HomePage(userData: facebookSignInController.userData),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Sign Up with Facebook'),
//                 style:
//                     ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _signUpWithSupabase(
//                     emailController.text,
//                     passwordController.text,
//                   );
//                 },
//                 child: Text('Sign Up with Supabase'),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   (
//                     AppleSignInButton(),
//                   );
//                 },
//                 child: Text('Sign Up with Apple'),
//                 style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 39, 44, 39)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

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
//       return;
//     }

//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     final UserCredential userCredential = await _auth.signInWithCredential(credential);

//     if (userCredential.user != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Sign in successful with Google!'),
//         ),
//       );

//       // Get user details
//       String email = userCredential.user?.email ?? '';
//       String displayName = googleUser.displayName ?? 'No Name';
//       String photoUrl = googleUser.photoUrl ?? '';

//       // Navigate to the HomePage and pass user details
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(
//             userData: {
//               'email': email,
//               'name': displayName,
//               'picture': photoUrl,
//             },
//           ),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Sign in failed with Google.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('An unexpected error occurred: ${e.toString()}'),
//         backgroundColor: Colors.red,
//       ),
//     );
//     print("error $e");
//   } finally {
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }

//   Future<void> _signUpWithFirebase(String email, String password) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       print("Firebase user signed up!");
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(userData: {'email': email}),
//         ),
//       );
//     } catch (e) {
//       print("Firebase sign-up failed: $e");
//     }
//   }

//   Future<void> _signUpWithSupabase(String email, String password) async {
//     final response = await Supabase.instance.client.auth.signUp(
//       email: email,
//       password: password,
//     );

//     if (response.user != null) {
//       print("Supabase user signed up!");
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(userData: {'email': email}),
//         ),
//       );
//     } else {
//       print("Supabase sign-up failed: ${response}");
//     }
//   }
// }

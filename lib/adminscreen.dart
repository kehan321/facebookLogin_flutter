// import 'package:fbsocial/signup.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:provider/provider.dart';
// import 'facebooksign.dart';


// class HomePage extends StatelessWidget {
//   final Map<String, dynamic>? userData;

//   HomePage({this.userData});

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   @override
//   Widget build(BuildContext context) {
//     final facebookSignInController =
//         Provider.of<FacebookSignInController>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => _logout(context, facebookSignInController),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (userData != null) ...[
//               Text('Name: ${userData!['name'] ?? 'No Name'}'),
//               Text('Email: ${userData!['email']}'),
//               if (userData!['picture'] != null)
//                 Image.network(userData!['picture']['data']['url']),
//             ],
//             // Additional user details can be displayed here
//           ],
//         ),
//       ),
//     );
//   }

//   void _logout(BuildContext context, FacebookSignInController facebookSignInController) async {
//     // Logout from Firebase
//     await _auth.signOut();

//     // Logout from Google
//     await _googleSignIn.signOut();

//     // Logout from Facebook
//     await facebookSignInController.logout();

//     // Logout from Supabase
//     await Supabase.instance.client.auth.signOut();

//     // Navigate back to SignUpPage
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => SignUpPage()),
//       (route) => false,
//     );
//   }
// }



import 'package:fbsocial/signup.dart';
import 'package:flutter/material.dart';
import 'package:fbsocial/facebooksign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// Make sure to import the SignUpPage

class HomePage extends StatelessWidget {
  final Map<String, dynamic>? userData;

  HomePage({this.userData});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final facebookSignInController =
        Provider.of<FacebookSignInController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blue,
        actions: [
           IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context, facebookSignInController),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userData != null) ...[
              Text('Name: ${userData!['name'] ?? 'No Name'}'),
              Text('Email: ${userData!['email']}'),
              if (userData!['picture'] != null)
                Image.network(userData!['picture']),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context, facebookSignInController),
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Button color
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context, FacebookSignInController facebookSignInController) async {
    try {
      // Logout from Firebase
      await _auth.signOut();

      // Logout from Google
      await _googleSignIn.signOut();

      // Logout from Facebook
      await facebookSignInController.logout();

      // Logout from Supabase
      await Supabase.instance.client.auth.signOut();

      // Navigate back to SignUpPage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred during logout: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


import 'package:fbsocial/adminscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:fbsocial/facebooksign.dart';
import 'package:fbsocial/applesignin.dart'; // Ensure you import the HomePage

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final facebookSignInController = Provider.of<FacebookSignInController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name TextField
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16),
            
            // Email TextField
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16),
            
            // Password TextField
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16),

            // Confirm Password TextField
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),

            // Sign Up with Firebase Button
            ElevatedButton(
              onPressed: () {
                if (passwordController.text == confirmPasswordController.text) {
                  _signUpWithFirebase(
                    emailController.text,
                    passwordController.text,
                    nameController.text,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Sign Up with Firebase'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),

            // Sign Up with Google Button
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text('Sign Up with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 20),

            // Sign Up with Facebook Button
          ElevatedButton(
  onPressed: () async {
    try {
      await facebookSignInController.login();
      if (facebookSignInController.userData != null) {
        final userData = facebookSignInController.userData;
        print('User data: $userData');
        
        // Ensure userData is a Map<String, dynamic>
        if (userData is Map<String, dynamic>) {
          // Access data safely
          String email = userData['email'] as String? ?? 'No Email';
          String name = userData['name'] as String? ?? 'No Name';
          String picture = userData['picture'] as String? ?? 'No Picture';

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                userData: {
                  'email': email,
                  'name': name,
                  'picture': picture,
                },
              ),
            ),
          );
        } else {
          print('Unexpected user data type: ${userData.runtimeType}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unexpected data type for user data.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Facebook sign-in failed. No user data found.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred during Facebook sign-in: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      print("Facebook sign-in error: $e");
    }
  },
  child: Text('Sign Up with Facebook'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueAccent,
    padding: EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
)
,
            
            
            SizedBox(height: 20),

            // Sign Up with Apple Button
            ElevatedButton(
              onPressed: () {
                AppleSignInButton();
              },
              child: Text('Sign Up with Apple'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 39, 44, 39),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in successful with Google!'),
          ),
        );

        // Get user details
        String email = userCredential.user?.email ?? '';
        String displayName = googleUser.displayName ?? 'No Name';
        String photoUrl = googleUser.photoUrl ?? '';

        // Navigate to the HomePage and pass user details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userData: {
                'email': email,
                'name': displayName,
                'picture': photoUrl,
              },
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in failed with Google.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      print("error $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signUpWithFirebase(String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("Firebase user signed up!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userData: {'email': email, 'name': name}),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-up failed with Firebase: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      print("Firebase sign-up failed: $e");
    }
  }

  // Removed the Supabase sign-up method
}

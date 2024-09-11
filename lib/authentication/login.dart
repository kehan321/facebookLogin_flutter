import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbsocial/adminscreen.dart';
import 'package:fbsocial/screens/doctor/doctorchat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';

Future<void> _login() async {
  if (_formKey.currentState?.validate() ?? false) {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Perform the Firebase authentication
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Check if the user exists in Firestore 'users' collection
      final userId = userCredential.user?.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        // User exists in Firestore
        if (_emailController.text.trim() == 'ifra@gmail.com' && _passwordController.text.trim() == 'ifra123') {
          // Navigate to DoctorChatPage for specific credentials
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorChatPage(
                doctorId: "10",
                doctorName: 'Patient Name', // Replace with appropriate patient name
              ),
            ),
          );
        } else {
          // Navigate to Admin/HomePage for other users
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(), // Replace with the correct homepage widget
            ),
          );
        }
      } else {
        // User does not exist in Firestore
        setState(() {
          _errorMessage = 'User does not exist. Please sign up.';
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text('Login'),
                    ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

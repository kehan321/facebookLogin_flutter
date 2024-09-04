import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String name;
  final String email;
  final String profilePicUrl;

  const HomePage({
    Key? key,
    required this.name,
    required this.email,
    required this.profilePicUrl, required Map<String, String> userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $name"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: $name"),
            Text("Email: $email"),
            profilePicUrl.isNotEmpty
                ? Image.network(profilePicUrl)
                : Icon(Icons.person, size: 100),
          ],
        ),
      ),
    );
  }
}

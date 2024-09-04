import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  ProfilePage({this.userData});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late String _profilePicture;
  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData?['name']);
    _emailController = TextEditingController(text: widget.userData?['email']);
    _profilePicture = widget.userData?['picture'] ?? '';
  }

  Future<void> _updateProfile() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      try {
        // Upload profile picture if there is a new one
        String? pictureUrl;
        if (_image != null) {
          final storageRef = FirebaseStorage.instance.ref().child('profile_pictures').child('${user.uid}.jpg');
          final uploadTask = storageRef.putFile(_image!);
          final snapshot = await uploadTask.whenComplete(() {});
          pictureUrl = await snapshot.ref.getDownloadURL();
        } else {
          pictureUrl = _profilePicture;
        }

        // Update Firebase Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': _nameController.text,
          'email': _emailController.text,
          'picture': pictureUrl,
        });

        // Optionally, you can also update Firebase Authentication profile (if needed)
        await user.updateProfile(displayName: _nameController.text, photoURL: pictureUrl);

        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

  Future<void> _changeProfilePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
        _profilePicture = image.path; // Update the picture path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: _changeProfilePicture,
            child: CircleAvatar(
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : (_profilePicture.isNotEmpty
                      ? NetworkImage(_profilePicture)
                      : null),
              child: _image == null && _profilePicture.isEmpty
                  ? Text(widget.userData?['name']?[0] ?? 'U')
                  : null,
              radius: 50,
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _updateProfile,
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}

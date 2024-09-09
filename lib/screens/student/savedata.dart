// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fbsocial/screens/student/model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';

// class AddDataPage extends StatefulWidget {
//   @override
//   _AddDataPageState createState() => _AddDataPageState();
// }

// class _AddDataPageState extends State<AddDataPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   // Controllers for input fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   PlatformFile? _cvFile;
//   PlatformFile? _profilePicFile; // New variable for profile picture

//   // Method to add user data
//   Future<void> _addData() async {
//     // String name = _nameController.text.trim();
//     String phone = _phoneController.text.trim();
//     String gender = _genderController.text.trim();

//     // Get the email and password from the currently signed-in user
//     User? user = _auth.currentUser;
//     String email = user?.email ?? '';
//     String uid = user?.uid ?? '';
//     String name = user?.displayName ?? '';

//     if (name.isEmpty || email.isEmpty || phone.isEmpty || gender.isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Please fill all fields')));
//       return;
//     }

//     try {
//       // Upload the CV file
//       String fileUrl = '';
//       if (_cvFile != null) {
//         fileUrl = await _uploadFile(File(_cvFile!.path!), 'resumes');
//       }

//       // Upload the profile picture file
//       String profilePicUrl = '';
//       if (_profilePicFile != null) {
//         profilePicUrl = await _uploadFile(File(_profilePicFile!.path!), 'profile_pictures');
//       }

//       // Create the UserModel instance
//       UserModel newUser = UserModel(
//         id: uid,
//         name: name,
//         email: email,
//         phone: phone,
//         gender: gender,
//         fileUrl: fileUrl,
//         profilePictureUrl: profilePicUrl, // Add profile picture URL here
//       );

//       // Add user data to Firestore in the 'users' collection
//       await _firestore.collection('users').doc(uid).set(newUser.toMap());

//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Data Added Successfully')));
//     } catch (e) {
//       print('Add data error: $e');
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   // File upload method
//   Future<String> _uploadFile(File file, String folder) async {
//     try {
//       final fileName =
//           '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
//       final storageRef = _storage.ref().child('$folder/$fileName');
//       final uploadTask = storageRef.putFile(file);
//       await uploadTask.whenComplete(() => null);
//       final downloadUrl = await storageRef.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('File upload error: $e');
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Data'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: 'Phone'),
//                 keyboardType: TextInputType.phone,
//               ),
//               DropdownButtonFormField<String>(
//                 value: _genderController.text.isEmpty
//                     ? null
//                     : _genderController.text,
//                 onChanged: (value) {
//                   setState(() {
//                     _genderController.text = value!;
//                   });
//                 },
//                 decoration: InputDecoration(labelText: 'Gender'),
//                 items: ['Male', 'Female', 'Other'].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final result = await FilePicker.platform.pickFiles();
//                   if (result != null && result.files.isNotEmpty) {
//                     setState(() {
//                       _cvFile = result.files.first;
//                     });
//                   }
//                 },
//                 child: Text('Upload CV'),
//               ),
//               if (_cvFile != null) Text('Uploaded: ${_cvFile!.name}'),
//               ElevatedButton(
//                 onPressed: () async {
//                   final result = await FilePicker.platform.pickFiles();
//                   if (result != null && result.files.isNotEmpty) {
//                     setState(() {
//                       _profilePicFile = result.files.first;
//                     });
//                   }
//                 },
//                 child: Text('Upload Profile Picture'),
//               ),
//               if (_profilePicFile != null)
//                 Text('Uploaded: ${_profilePicFile!.name}'),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _addData,
//                 child: Text('Add Data'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbsocial/screens/student/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Controllers for input fields
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  PlatformFile? _cvFile;
  PlatformFile? _profilePicFile; // New variable for profile picture

  // Method to add user data
  Future<void> _addData() async {
    String phone = _phoneController.text.trim();
    String gender = _genderController.text.trim();

    // Get the email, name, and uid from the currently signed-in user
    User? user = _auth.currentUser;
    String email = user?.email ?? '';
    String uid = user?.uid ?? '';
    String name = user?.displayName ?? ''; // Get the name from FirebaseAuth

    if (name.isEmpty || email.isEmpty || phone.isEmpty || gender.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    try {
      // Upload the CV file
      String fileUrl = '';
      if (_cvFile != null) {
        fileUrl = await _uploadFile(File(_cvFile!.path!), 'resumes');
      }

      // Upload the profile picture file
      String profilePicUrl = '';
      if (_profilePicFile != null) {
        profilePicUrl = await _uploadFile(File(_profilePicFile!.path!), 'profile_pictures');
      }

      // Create the UserModel instance
      UserModel newUser = UserModel(
        id: uid,
        name: name,
        email: email,
        phone: phone,
        gender: gender,
        fileUrl: fileUrl,
        profilePictureUrl: profilePicUrl, // Add profile picture URL here
      );

      // Add user data to Firestore in the 'users' collection
      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data Added Successfully')));
    } catch (e) {
      print('Add data error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // File upload method
  Future<String> _uploadFile(File file, String folder) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
      final storageRef = _storage.ref().child('$folder/$fileName');
      final uploadTask = storageRef.putFile(file);
      await uploadTask.whenComplete(() => null);
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('File upload error: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Removed Name input field since name is taken from FirebaseAuth
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              DropdownButtonFormField<String>(
                value: _genderController.text.isEmpty
                    ? null
                    : _genderController.text,
                onChanged: (value) {
                  setState(() {
                    _genderController.text = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      _cvFile = result.files.first;
                    });
                  }
                },
                child: Text('Upload CV'),
              ),
              if (_cvFile != null) Text('Uploaded: ${_cvFile!.name}'),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      _profilePicFile = result.files.first;
                    });
                  }
                },
                child: Text('Upload Profile Picture'),
              ),
              if (_profilePicFile != null)
                Text('Uploaded: ${_profilePicFile!.name}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addData,
                child: Text('Add Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

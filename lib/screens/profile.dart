// import 'package:flutter/material.dart';

// class User {
//   final String id;
//   final String name;
//   final String email;
//   final String phone;
//   final String gender;
//   final String fileUrl;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.gender,
//     required this.fileUrl,
//   });
// }

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final List<User> _users = [
//     User(id: '1', name: 'John Doe', email: 'john.doe@example.com', phone: '1234567890', gender: 'Male', fileUrl: 'http://example.com/file.jpg'),
//     // Add more users as needed
//   ];

//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Page'),
//       ),
//       body: _buildUserList(),
//     );
//   }

//   Widget _buildUserList() {
//     return ListView.builder(
//       itemCount: _users.length,
//       itemBuilder: (context, index) {
//         final user = _users[index];
//         return Card(
//           elevation: 3,
//           margin: EdgeInsets.symmetric(vertical: 8.0),
//           child: ListTile(
//             contentPadding: EdgeInsets.all(16.0),
//             title: Text(user.name),
//             subtitle: Text('${user.email}\n${user.phone}\n${user.gender}\n${user.fileUrl}'),
//             isThreeLine: true,
//             trailing: IconButton(
//               icon: Icon(Icons.delete, color: Colors.red),
//               onPressed: () {
//                 _showDeleteConfirmationDialog(user.id);
//               },
//             ),
//             onTap: () {
//               _phoneController.text = user.phone;
//               _genderController.text = user.gender;
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Update User'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextField(
//                         controller: TextEditingController(text: user.name),
//                         decoration: InputDecoration(labelText: 'Name'),
//                         readOnly: true,
//                       ),
//                       SizedBox(height: 10),
//                       TextField(
//                         controller: TextEditingController(text: user.email),
//                         decoration: InputDecoration(labelText: 'Email'),
//                         readOnly: true,
//                       ),
//                       SizedBox(height: 10),
//                       TextField(
//                         controller: _phoneController,
//                         decoration: InputDecoration(labelText: 'Phone Number'),
//                       ),
//                       SizedBox(height: 10),
//                       DropdownButtonFormField<String>(
//                         value: user.gender.isEmpty ? null : user.gender,
//                         onChanged: (value) {
//                           setState(() {
//                             _genderController.text = value!;
//                           });
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Gender',
//                           border: OutlineInputBorder(),
//                         ),
//                         items: <String>['Male', 'Female', 'Other'].map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         _updateUser(user.id);
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Update'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Text('Cancel'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   void _showDeleteConfirmationDialog(String userId) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Confirm Deletion'),
//         content: Text('Are you sure you want to delete this user?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _deleteUser(userId);
//               Navigator.of(context).pop();
//             },
//             child: Text('Delete'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _updateUser(String userId) {
//     // Find the user to update
//     final userIndex = _users.indexWhere((user) => user.id == userId);
//     if (userIndex == -1) return; // User not found

//     setState(() {
//       // Update the user's details
//       _users[userIndex] = User(
//         id: userId,
//         name: _users[userIndex].name, // Assuming name is not updated
//         email: _users[userIndex].email, // Assuming email is not updated
//         phone: _phoneController.text,
//         gender: _genderController.text,
//         fileUrl: _users[userIndex].fileUrl, // Assuming fileUrl is not updated
//       );
//     });
//   }

//   void _deleteUser(String userId) {
//     setState(() {
//       _users.removeWhere((user) => user.id == userId);
//     });
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // Import the User model

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
// // user.dart

// class User {
//   final String id;
//   final String name;
//   final String email;
//   final String phone;
//   final String gender;
//   final String fileUrl;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.gender,
//     required this.fileUrl,
//   });

//   // Factory method to create a User from a Firestore document
//   factory User.fromFirestore(Map<String, dynamic> data, String id) {
//     return User(
//       id: id,
//       name: data['name'] ?? '',
//       email: data['email'] ?? '',
//       phone: data['phone'] ?? '',
//       gender: data['gender'] ?? '',
//       fileUrl: data['fileUrl'] ?? '',
//     );
//   }
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();

//   // Define the _getUsersStream method
//   Stream<List<User>> _getUsersStream() {
//     return _firestore.collection('users').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         return User.fromFirestore(data, doc.id);
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Page'),
//       ),
//       body: StreamBuilder<List<User>>(
//         stream: _getUsersStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No users found.'));
//           }

//           final users = snapshot.data!;

//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return Card(
//                 elevation: 3,
//                 margin: EdgeInsets.symmetric(vertical: 8.0),
//                 child: ListTile(
//                   contentPadding: EdgeInsets.all(16.0),
//                   title: Text(user.name),
//                   subtitle: Text(
//                       '${user.email}\n${user.phone}\n${user.gender}\n${user.fileUrl}'),
//                   isThreeLine: true,
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete, color: Colors.red),
//                     onPressed: () {
//                       _showDeleteConfirmationDialog(user.id);
//                     },
//                   ),
//                   onTap: () {
//                     _phoneController.text = user.phone;
//                     _genderController.text = user.gender;
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('Update User'),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             TextField(
//                               controller:
//                                   TextEditingController(text: user.name),
//                               decoration: InputDecoration(labelText: 'Name'),
//                               readOnly: true,
//                             ),
//                             SizedBox(height: 10),
//                             TextField(
//                               controller:
//                                   TextEditingController(text: user.email),
//                               decoration: InputDecoration(labelText: 'Email'),
//                               readOnly: true,
//                             ),
//                             SizedBox(height: 10),
//                             TextField(
//                               controller: _phoneController,
//                               decoration:
//                                   InputDecoration(labelText: 'Phone Number'),
//                             ),
//                             SizedBox(height: 10),
//                             DropdownButtonFormField<String>(
//                               value: user.gender.isEmpty ? null : user.gender,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _genderController.text = value!;
//                                 });
//                               },
//                               decoration: InputDecoration(
//                                 labelText: 'Gender',
//                                 border: OutlineInputBorder(),
//                               ),
//                               items: <String>['Male', 'Female', 'Other']
//                                   .map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               _updateUser(user.id);
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('Update'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('Cancel'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showDeleteConfirmationDialog(String userId) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Confirm Deletion'),
//         content: Text('Are you sure you want to delete this user?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _deleteUser(userId);
//               Navigator.of(context).pop();
//             },
//             child: Text('Delete'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _updateUser(String userId) {
//     _firestore.collection('students').doc(userId).update({
//       'phone': _phoneController.text,
//       'gender': _genderController.text,
//     }).then((_) {
//       print('User updated successfully');
//     }).catchError((error) {
//       print('Failed to update user: $error');
//     });
//   }

//   void _deleteUser(String userId) {
//     _firestore.collection('students').doc(userId).delete().then((_) {
//       print('User deleted successfully');
//     }).catchError((error) {
//       print('Failed to delete user: $error');
//     });
//   }
// }





// import 'dart:io'; // For File
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart'; // To get the app directory for downloading files

// class UserModel {
//   final String id;
//   final String name;
//   final String email;
//   final String phone;
//   final String gender;
//   final String fileUrl;
//   final String profilePictureUrl; // New field

//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.gender,
//     required this.fileUrl,
//     required this.profilePictureUrl, // Add this in the constructor
//   });

//   factory UserModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return UserModel(
//       id: doc.id,
//       name: data['name'] ?? '',
//       email: data['email'] ?? '',
//       phone: data['phone'] ?? '',
//       gender: data['gender'] ?? '',
//       fileUrl: data['fileUrl'] ?? '',
//       profilePictureUrl: data['profilePictureUrl'] ?? '', // New field
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//       'phone': phone,
//       'gender': gender,
//       'fileUrl': fileUrl,
//       'profilePictureUrl': profilePictureUrl, // New field
//     };
//   }
// }

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();

//   Stream<UserModel?> _getUserStream() {
//     final currentUser = _auth.currentUser;
//     if (currentUser == null) {
//       return Stream.value(null); // Return null if no user is logged in
//     }

//     final userEmail = currentUser.email;
//     return _firestore
//         .collection('users')
//         .where('email', isEqualTo: userEmail) // Query by email
//         .snapshots()
//         .map((snapshot) {
//       if (snapshot.docs.isEmpty) {
//         return null; // No user found
//       }
//       final doc = snapshot.docs.first;
//       return UserModel.fromFirestore(doc);
//     });
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       final storageRef =
//           _storage.ref().child('profile_pics/${_auth.currentUser!.uid}');
//       await storageRef.putFile(file);
//       final downloadUrl = await storageRef.getDownloadURL();
//       _updateProfilePicture(downloadUrl);
//     }
//   }

//   Future<void> _pickResume() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       final file = File(result.files.single.path!);
//       final storageRef =
//           _storage.ref().child('resumes/${_auth.currentUser!.uid}');
//       await storageRef.putFile(file);
//       final downloadUrl = await storageRef.getDownloadURL();
//       _updateResumeFile(downloadUrl);
//     }
//   }

//   Future<void> _downloadResume(String resumeUrl) async {
//     try {
//       // Get the directory where files are stored
//       final dir = await getApplicationDocumentsDirectory();

//       // Set up the file path where the resume will be saved
//       final filePath = '${dir.path}/resume.pdf'; // Use the desired file name

//       // Use Dio package to download the resume
//       final dio = Dio();
//       await dio.download(resumeUrl, filePath);

//       // Show a success message once the download is complete
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Resume downloaded successfully')),
//       );

//       // Open the file after downloading
//       final result = await OpenFile.open(filePath);

//       // Check if the file was opened successfully
//       // if (result.type == ResultType.done) {
//       //   print('File opened successfully');
//       // } else {
//       //   ScaffoldMessenger.of(context).showSnackBar(
//       //     SnackBar(content: Text('Failed to open file: ${result.message}')),
//       //   );
//       //   print('Failed to open file: ${result.message}');
//       // }
//     } catch (e) {
//       // Handle any errors during download
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to download resume: $e')),
//       );
//       print("Error: $e");
//     }
//   }

//   void _updateProfilePicture(String fileUrl) {
//     final userId = _auth.currentUser!.uid;
//     _firestore.collection('users').doc(userId).update({
//       'profilePictureUrl': fileUrl, // Update the field name
//     }).then((_) {
//       print('Profile picture updated successfully');
//     }).catchError((error) {
//       print('Failed to update profile picture: $error');
//     });
//   }

//   void _updateResumeFile(String resumeUrl) {
//     final userId = _auth.currentUser!.uid;
//     _firestore.collection('users').doc(userId).update({
//       'fileUrl': resumeUrl, // Update the field name
//     }).then((_) {
//       print('Resume file updated successfully');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Resume updated successfully')),
//       );
//     }).catchError((e) {
//       print('Failed to update resume file: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update resume file: $e')),
//       );
//     });
//   }

//   void _showDeleteConfirmationDialog(String userId) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Confirm Deletion'),
//         content: Text('Are you sure you want to delete this user?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _deleteUserData();
//               Navigator.of(context).pop();
//             },
//             child: Text('Delete'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _deleteUserData() async {
//     final userId = _auth.currentUser!.uid;
//     try {
//       await _firestore.collection('users').doc(userId).delete();
//       print('User data deleted successfully from Firestore');
//     } catch (e) {
//       print('Failed to delete user data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<UserModel?>(
//         stream: _getUserStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('No user found.'));
//           }

//           final user = snapshot.data!;

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: GestureDetector(
//                     onTap: _pickImage,
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: user.profilePictureUrl.isNotEmpty
//                           ? NetworkImage(user.profilePictureUrl)
//                           : AssetImage('assets/default_profile.png')
//                               as ImageProvider,
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Icon(Icons.camera_alt,
//                             color: Colors.white, size: 24),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   user.name,
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 Text(user.email, style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 20),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: Colors.grey[200],
//                   ),
//                   child: Column(
//                     children: [
//                       ListTile(
//                         contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                         leading: Icon(Icons.phone, color: Colors.blue),
//                         title: Text('Phone'),
//                         subtitle: Text(user.phone),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit, color: Colors.blue),
//                           onPressed: () {
//                             // Edit phone logic
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                         leading: Icon(Icons.transgender, color: Colors.blue),
//                         title: Text('Gender'),
//                         subtitle: Text(user.gender),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit, color: Colors.blue),
//                           onPressed: () {
//                             // Edit gender logic
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
//                         leading: Icon(Icons.file_present, color: Colors.blue),
//                         title: Text('Resume'),
//                         subtitle: Text(user.fileUrl.isNotEmpty ? 'File Available' : 'No File'),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.file_upload, color: Colors.blue),
//                               onPressed: _pickResume,
//                             ),
//                             if (user.fileUrl.isNotEmpty)
//                               IconButton(
//                                 icon: Icon(Icons.download, color: Colors.blue),
//                                 onPressed: () => _downloadResume(user.fileUrl),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _showDeleteConfirmationDialog(user.id);
//                     },
//                     child: Text('Delete Account'),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white, backgroundColor: Colors.red,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
























import 'dart:io'; // For File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart'; // To get the app directory for downloading files

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String fileUrl;
  final String profilePictureUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.fileUrl,
    required this.profilePictureUrl,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      gender: data['gender'] ?? '',
      fileUrl: data['fileUrl'] ?? '',
      profilePictureUrl: data['profilePictureUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'fileUrl': fileUrl,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _phoneController = TextEditingController();
  final List<String> _genders = ['Male', 'Female', 'Other'];
  String? _selectedGender;

  Stream<UserModel?> _getUserStream() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Stream.value(null); // Return null if no user is logged in
    }

    final userEmail = currentUser.email;
    return _firestore
        .collection('users')
        .where('email', isEqualTo: userEmail) // Query by email
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null; // No user found
      }
      final doc = snapshot.docs.first;
      return UserModel.fromFirestore(doc);
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageRef =
          _storage.ref().child('profile_pics/${_auth.currentUser!.uid}');
      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();
      _updateProfilePicture(downloadUrl);
    }
  }

  Future<void> _pickResume() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);
      final storageRef =
          _storage.ref().child('resumes/${_auth.currentUser!.uid}');
      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();
      _updateResumeFile(downloadUrl);
    }
  }

  Future<void> _downloadResume(String resumeUrl) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/resume.pdf'; // Use the desired file name
      final dio = Dio();
      await dio.download(resumeUrl, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resume downloaded successfully')),
      );

      final result = await OpenFile.open(filePath);

      // if (result.type == ResultType.done) {
      //   print('File opened successfully');
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Failed to open file: ${result.message}')),
      //   );
      //   print('Failed to open file: ${result.message}');
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download resume: $e')),
      );
      print("Error: $e");
    }
  }

  void _updateProfilePicture(String fileUrl) {
    final userId = _auth.currentUser!.uid;
    _firestore.collection('users').doc(userId).update({
      'profilePictureUrl': fileUrl,
    }).then((_) {
      print('Profile picture updated successfully');
    }).catchError((error) {
      print('Failed to update profile picture: $error');
    });
  }

  void _updateResumeFile(String resumeUrl) {
    final userId = _auth.currentUser!.uid;
    _firestore.collection('users').doc(userId).update({
      'fileUrl': resumeUrl,
    }).then((_) {
      print('Resume file updated successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resume updated successfully')),
      );
    }).catchError((e) {
      print('Failed to update resume file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update resume file: $e')),
      );
    });
  }

  void _showPhoneUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Phone Number'),
          content: TextField(
            controller: _phoneController,
            decoration: InputDecoration(hintText: 'Enter new phone number'),
            keyboardType: TextInputType.phone,
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newPhone = _phoneController.text.trim();
                if (newPhone.isNotEmpty) {
                  _updatePhoneNumber(newPhone);
                }
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _updatePhoneNumber(String newPhone) {
    final userId = _auth.currentUser!.uid;
    _firestore.collection('users').doc(userId).update({
      'phone': newPhone,
    }).then((_) {
      print('Phone number updated successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number updated successfully')),
      );
    }).catchError((error) {
      print('Failed to update phone number: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update phone number: $error')),
      );
    });
  }

  void _showGenderUpdateDialog(String currentGender) {
    _selectedGender = currentGender; // Set initial value
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Gender'),
          content: DropdownButton<String>(
            value: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
            items: _genders.map((gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_selectedGender != null) {
                  _updateGender(_selectedGender!);
                }
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _updateGender(String newGender) {
    final userId = _auth.currentUser!.uid;
    _firestore.collection('users').doc(userId).update({
      'gender': newGender,
    }).then((_) {
      print('Gender updated successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gender updated successfully')),
      );
    }).catchError((error) {
      print('Failed to update gender: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update gender: $error')),
      );
    });
  }

  void _showDeleteConfirmationDialog(String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete your account?'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteUser(userId);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      print('User deleted successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User deleted successfully')),
      );
    } catch (error) {
      print('Failed to delete user: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              final userId = _auth.currentUser!.uid;
              _showDeleteConfirmationDialog(userId);
            },
          ),
        ],
      ),
      body: StreamBuilder<UserModel?>(
        stream: _getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No user data available'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: user.profilePictureUrl.isNotEmpty
                          ? NetworkImage(user.profilePictureUrl)
                          : AssetImage('assets/default_profile.png') as ImageProvider,
                      backgroundColor: Colors.grey[200],
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.teal, size: 30),
                      onPressed: _pickImage,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(user.name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text(user.email, style: TextStyle(fontSize: 18, color: Colors.grey)),
                SizedBox(height: 20),
                _buildInfoRow('Phone: ${user.phone}', Icons.phone, _showPhoneUpdateDialog),
                SizedBox(height: 10),
                _buildInfoRow('Gender: ${user.gender}', Icons.transgender, () => _showGenderUpdateDialog(user.gender)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickResume,
                  child: Text('Upload Resume'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 10),
                if (user.fileUrl.isNotEmpty)
                  ElevatedButton(
                    onPressed: () => _downloadResume(user.fileUrl),
                    child: Text('Download Resume'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String text, IconData icon, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.teal),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 18)),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.edit, color: Colors.teal),
          onPressed: onPressed,
        ),
      ],
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fbsocial/screens/student/model.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class UserListPage extends StatefulWidget {
//   @override
//   _UserListPageState createState() => _UserListPageState();
// }

// class _UserListPageState extends State<UserListPage> {
//   final _phoneController = TextEditingController();
//   final _genderController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final _picker = ImagePicker();
//   XFile? _cvFile;
//   late List<UserModel> _users;
//   String? _name;
//   String? _email;

//   @override
//   void initState() {
//     super.initState();
//     _fetchCurrentUser();
//     _fetchUsers();
//   }

//   Future<void> _fetchCurrentUser() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         _name = user.displayName ?? '';
//         _email = user.email ?? '';
//       });
//     }
//   }

//   Future<void> _fetchUsers() async {
//     final snapshot = await _firestore.collection('users').get();
//     setState(() {
//       _users = snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
//     });
//   }

//   Future<void> _addUser() async {
//     if (_name == null || _email == null ||
//         _phoneController.text.isEmpty ||
//         _genderController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('All fields are required')),
//       );
//       return;
//     }

//     final user = UserModel(
//       id: '',
//       name: _name!,
//       email: _email!,
//       phone: _phoneController.text,
//       gender: _genderController.text,
//       fileUrl: _cvFile?.path ?? '',
//     );

//     final ref = _firestore.collection('users').doc();
//     await ref.set(user.toMap());
//     _clearFields();
//     _fetchUsers();
//   }

//   Future<void> _updateUser(String id) async {
//     final updatedUser = UserModel(
//       id: id,
//       name: _name!,
//       email: _email!,
//       phone: _phoneController.text,
//       gender: _genderController.text,
//       fileUrl: _cvFile?.path ?? '',
//     );

//     await _firestore.collection('users').doc(id).update(updatedUser.toMap());
//     _clearFields();
//     _fetchUsers();
//   }

//   Future<void> _deleteUser(String id) async {
//     await _firestore.collection('users').doc(id).delete();
//     _fetchUsers();
//   }

//   void _clearFields() {
//     _phoneController.clear();
//     _genderController.clear();
//     _cvFile = null;
//   }

//   Future<void> _pickCv() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _cvFile = pickedFile;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Management'),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildInputForm(),
//             SizedBox(height: 20),
//             Expanded(child: _buildUserList()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputForm() {
//     return Card(
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Add New User'),
//             SizedBox(height: 10),
//             TextField(
//               controller: TextEditingController(text: _name),
//               decoration: InputDecoration(
//                 labelText: 'Name',
//                 border: OutlineInputBorder(),
//               ),
//               readOnly: true,
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: TextEditingController(text: _email),
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//               readOnly: true,
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 10),
//             DropdownButtonFormField<String>(
//               value: _genderController.text.isEmpty ? null : _genderController.text,
//               onChanged: (value) {
//                 setState(() {
//                   _genderController.text = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Gender',
//                 border: OutlineInputBorder(),
//               ),
//               items: <String>['Male', 'Female', 'Other'].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickCv,
//               child: Text('Upload CV'),
//             ),
//             SizedBox(height: 10),
//             if (_cvFile != null)
//               Text('Uploaded CV: ${_cvFile!.name}'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _addUser,
//               child: Text('Add User'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueGrey,
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                 textStyle: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
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
// }

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fbsocial/screens/student/model.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class UserListPage extends StatefulWidget {
//   @override
//   _UserListPageState createState() => _UserListPageState();
// }

// class _UserListPageState extends State<UserListPage> {
//   final _phoneController = TextEditingController();
//   final _genderController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   PlatformFile? _cvFile;
//   late List<UserModel> _users;
//   String? _name;
//   String? _email;

//   @override
//   void initState() {
//     super.initState();
//     _fetchCurrentUser();
//     _fetchUsers();
//   }

//   Future<void> _fetchCurrentUser() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         _name = user.displayName ?? '';
//         _email = user.email ?? '';
//       });
//     }
//   }

//   Future<void> _fetchUsers() async {
//     final snapshot = await _firestore.collection('users').get();
//     setState(() {
//       _users =
//           snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
//     });
//   }

//   Future<void> _addUser() async {
//     if (_name == null ||
//         _email == null ||
//         _phoneController.text.isEmpty ||
//         _genderController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('All fields are required')),
//       );
//       return;
//     }

//     // Upload CV to Firebase Storage and get the download URL
//     String fileUrl = '';
//     if (_cvFile != null) {
//       fileUrl = await _uploadFile(File(_cvFile!.path!));
//     }

//     final user = UserModel(
//       id: _email!, // Using email as the ID
//       name: _name!,
//       email: _email!,
//       phone: _phoneController.text,
//       gender: _genderController.text,
//       fileUrl: fileUrl,
//     );


//     // Save the user to Firestore using the email as the document ID
//     final ref = _firestore.collection('users').doc(_email
      
//     );

//     // Check if the user already exists (optional)
//     final docSnapshot = await ref.get();
//     if (docSnapshot.exists) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('User with this email already exists')),
//       );
//     } else {
//       await ref.set(user.toMap());
//       _clearFields();
//       _fetchUsers();
//     }
//   }

//   Future<void> _updateUser(String id) async {
//     String fileUrl = '';
//     if (_cvFile != null) {
//       fileUrl = await _uploadFile(File(_cvFile!.path!));
//     }

//     final updatedUser = UserModel(
//       id: id,
//       name: _name!,
//       email: _email!,
//       phone: _phoneController.text,
//       gender: _genderController.text,
//       fileUrl: fileUrl,
//     );

//     await _firestore.collection('users').doc(id).update(updatedUser.toMap());
//     _clearFields();
//     _fetchUsers();
//   }

//   Future<void> _deleteUser(String id) async {
//     await _firestore.collection('users').doc(id).delete();
//     _fetchUsers();
//   }

//   void _clearFields() {
//     _phoneController.clear();
//     _genderController.clear();
//     _cvFile = null;
//   }

//   Future<void> _pickCv() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result != null && result.files.isNotEmpty) {
//       setState(() {
//         _cvFile = result.files.first;
//       });
//     }
//   }

//   Future<String> _uploadFile(File file) async {
//     try {
//       final fileName =
//           '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
//       final storageRef = _storage.ref().child('resumes/$fileName');
//       final uploadTask = storageRef.putFile(file);

//       // Wait for the upload to complete
//       await uploadTask.whenComplete(() => null);

//       // Get the download URL
//       final downloadUrl = await storageRef.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading file: $e');
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildInputForm(),
//             SizedBox(height: 20),
//             Expanded(child: _buildUserList()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInputForm() {
//     return Card(
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Add New User'),
//             SizedBox(height: 10),
//             TextField(
//               controller: TextEditingController(text: _name),
//               decoration: InputDecoration(
//                 labelText: 'Name',
//                 border: OutlineInputBorder(),
//               ),
//               readOnly: true,
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: TextEditingController(text: _email),
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//               readOnly: true,
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 10),
//             DropdownButtonFormField<String>(
//               value: _genderController.text.isEmpty
//                   ? null
//                   : _genderController.text,
//               onChanged: (value) {
//                 setState(() {
//                   _genderController.text = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Gender',
//                 border: OutlineInputBorder(),
//               ),
//               items: <String>['Male', 'Female', 'Other'].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickCv,
//               child: Text('Upload CV'),
//             ),
//             SizedBox(height: 10),
//             if (_cvFile != null) Text('Uploaded CV: ${_cvFile!.name}'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _addUser,
//               child: Text('Add User'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueGrey,
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                 textStyle: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUserList() {
//     return ListView.builder(
//       itemCount: _users.length,
//       itemBuilder: (context, index) {
//         final user = _users[index];
//         return;
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
// }

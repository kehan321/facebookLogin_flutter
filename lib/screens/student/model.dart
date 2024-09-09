import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Student {
  final String id;
  final String name;
  final String email;
  final Map<String, int> marks;
  final String companyRequirement;
  String? profilePictureUrl;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.marks,
    required this.companyRequirement,
    this.profilePictureUrl,
  });

  Future<String?> uploadProfilePicture(File imageFile) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child('$id.jpg');

    try {
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading profile picture: $e');
      return null;
    }
  }

  Future<void> saveToFirestore() async {
    final studentRef = FirebaseFirestore.instance.collection('students').doc(id);

    try {
      await studentRef.set({
        'name': name,
        'email': email,
        'marks': marks,
        'companyRequirement': companyRequirement,
        'profilePictureUrl': profilePictureUrl,
      });
      print('Student profile saved to Firestore');
    } catch (e) {
      print('Error saving student profile: $e');
    }
  }
}



class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String fileUrl;
  final String profilePictureUrl; // New field

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.fileUrl,
    required this.profilePictureUrl, // Add this in the constructor
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
      profilePictureUrl: data['profilePictureUrl'] ?? '', // New field
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'fileUrl': fileUrl,
      'profilePictureUrl': profilePictureUrl, // New field
    };
  }
}

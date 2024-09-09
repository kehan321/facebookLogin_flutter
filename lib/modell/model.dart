import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewpageModel extends ChangeNotifier {
  // Controllers for your form fields
  TextEditingController? textController1;
  FocusNode? textFieldFocusNode1;
  
  TextEditingController? textController2;
  FocusNode? textFieldFocusNode2;

  // GlobalKey for form validation
  final formKey = GlobalKey<FormState>();

  // Dispose method to clean up controllers
  @override
  void dispose() {
    textController1?.dispose();
    textFieldFocusNode1?.dispose();
    textController2?.dispose();
    textFieldFocusNode2?.dispose();
    super.dispose();
  }

  // Add validators for your form fields if needed
  String? textController1Validator(String? value) {
    // Add validation logic here
    return null;
  }

  String? textController2Validator(String? value) {
    // Add validation logic here
    return null;
  }
}




// class Doctor {
//   final String imageUrl;
//   final String name;
//   final String occupation;
//   final double ratings;

//   Doctor({required this.imageUrl, required this.name, required this.occupation, required this.ratings});

//   // Create a Doctor object from Firestore snapshot
//   factory Doctor.fromFirestore(DocumentSnapshot doc) {
//     Map data = doc.data() as Map<String, dynamic>;
//     return Doctor(
//       imageUrl: data['imageUrl'] ?? '',
//       name: data['name'] ?? '',
//       occupation: data['occupation'] ?? '',
//       ratings: (data['ratings'] as num).toDouble(),
//     );
//   }
// }

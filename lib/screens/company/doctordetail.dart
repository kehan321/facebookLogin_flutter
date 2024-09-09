    
    // Scaffold(
    //   appBar: AppBar(
    //     title: Text(doctor.name),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         CircleAvatar(
    //           radius: 80,
    //           backgroundImage: NetworkImage(doctor.imageUrl),
    //           backgroundColor: Colors.transparent,
    //         ),
    //         SizedBox(height: 16),
    //         Text(
    //           doctor.name,
    //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(height: 8),
    //         Text(
    //           doctor.occupation,
    //           style: TextStyle(fontSize: 18, color: Colors.grey[600]),
    //         ),
    //         SizedBox(height: 16),
    //         Text(
    //           'Ratings: ${doctor.ratings}',
    //           style: TextStyle(fontSize: 18),
    //         ),
    //         SizedBox(height: 16),
    //         // Add more details about the doctor here
    //         Text(
    //           'Detailed information about the doctor goes here.',
    //           style: TextStyle(fontSize: 16),
    //         ),
    //       ],
    //     ),
    //   ),
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbsocial/screens/company/company.dart';
import 'package:flutter/material.dart';
import 'package:fbsocial/authentication/colors.dart';

class DoctorDetailPage extends StatelessWidget {
  final Doctor doctor;

  DoctorDetailPage({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFFFBE00),
        child: Stack(
          children: [
            Positioned(
              top: 40, 
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp, size: 30),
                onPressed: () {
                  Navigator.pop(context); 
                },
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60), 
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(doctor.imageUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 10),
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    doctor.occupation,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.call,
                            size: 30,
                            color: AppColors.appBarColor,
                          ),
                          onPressed: () {
                            // Add call action
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.chat,
                            size: 30,
                            color: AppColors.appBarColor,
                          ),
                          onPressed: () {
                            // Add chat action
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Positioned.fill(
              top: 320,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: doctor.symptoms
                        .map((symptom) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                symptom,
                                style: TextStyle(fontSize: 16),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 6,
              left: 30,
              right: 30,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Consultation Price:"),
                      Text(
                        '\$${doctor.consultationPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add calculation logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.8,
                        70,
                      ),
                    ),
                    child: Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Doctor {
//   final String imageUrl;
//   final String name;
//   final String occupation;
//   final double ratings;
//   final double consultationPrice;
//   final List<String> symptoms;

//   Doctor({
//     required this.imageUrl,
//     required this.name,
//     required this.occupation,
//     required this.ratings,
//     required this.consultationPrice,
//     required this.symptoms,
//   });

//   factory Doctor.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return Doctor(
//       imageUrl: data['imageUrl'] ?? '',
//       name: data['name'] ?? '',
//       occupation: data['occupation'] ?? '',
//       ratings: (data['ratings'] as num).toDouble(),
//       consultationPrice: (data['consultationPrice'] as num).toDouble(),
//       symptoms: List<String>.from(data['symptoms'] ?? []),
//     );
//   }
// }

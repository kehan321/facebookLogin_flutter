import 'dart:ui';

import 'package:fbsocial/screens/company/company.dart';
import 'package:flutter/material.dart';

class DoctorDetailPage extends StatelessWidget {
  final Doctor doctor;

  DoctorDetailPage({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(doctor.imageUrl),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 16),
            Text(
              doctor.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              doctor.occupation,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text(
              'Ratings: ${doctor.ratings}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            // Add more details about the doctor here
            Text(
              'Detailed information about the doctor goes here.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

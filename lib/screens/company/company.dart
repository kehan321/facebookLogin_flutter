import 'package:fbsocial/authentication/colors.dart';
import 'package:fbsocial/screens/company/doctordetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyHomePage extends StatefulWidget {
  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  // Set default selected symptom to "All"
  String? _selectedSymptom = "All";

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      color: AppColors.whiteColor,
      child: SingleChildScrollView(
        
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SimpleDoctorCard(
                      title: 'Clinic Visit',
                      subtitle: 'Make an appointment',
                      icon: Icons.add,
                      iconColor: AppColors.whiteColor,
                      backgroundColor: AppColors.backgroundColor,
                      cardColor: const Color.fromARGB(255, 255, 232, 162),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SimpleDoctorCard(
                      title: 'Home Visit',
                      subtitle: 'Call the doctor home',
                      icon: Icons.home,
                      iconColor: AppColors.whiteColor,
                      backgroundColor: AppColors.backgroundColor,
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
      
      
              ///////////////////////////////R1//////////////////////
              Text("What are your symptoms?", style: GoogleFonts.roboto(fontSize: 20),),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _symptomButton("All"),
                    SizedBox(width: 10),
                    _symptomButton("Fever"),
                    SizedBox(width: 10),
                    _symptomButton("Cough"),
                    SizedBox(width: 10),
                    _symptomButton("Headache"),
                    SizedBox(width: 10),
                    _symptomButton("Shortness of Breath"),
                    SizedBox(width: 10),
                    _symptomButton("Fatigue"),
                  ],
                ),
              ),
                          SizedBox(height: 15),
      
              Text("Popular Doctors", style: GoogleFonts.roboto(fontSize: 20),),
                          SizedBox(height: 15),
      
              DoctorsGrid(selectedSymptom: _selectedSymptom),
            ],
          ),
        ),
      ),
    );
  }

  Widget _symptomButton(String text) {
    bool isSelected = _selectedSymptom == text;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedSymptom = text; // Set selected symptom
        });
      },
      child: Text(
        text,
        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          isSelected ? AppColors.backgroundColor : Colors.white,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          isSelected ? Colors.black : Colors.black87,
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: isSelected ? AppColors.backgroundColor : Colors.grey,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorsGrid extends StatelessWidget {
  final String? selectedSymptom;

  DoctorsGrid({this.selectedSymptom});

  Future<List<Doctor>> fetchDoctors() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('doctors').get();
      print('Fetched ${querySnapshot.docs.length} doctors');
      return querySnapshot.docs
          .map((doc) => Doctor.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching doctors: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Doctor>>(
      future: fetchDoctors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No doctors found'));
        }

        final doctors = snapshot.data!;

        // Filter doctors based on the selected symptom
        final filteredDoctors = selectedSymptom == "All"
            ? doctors
            : doctors
                .where((doctor) => doctor.symptoms.contains(selectedSymptom!))
                .toList();

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.8,
          ),
          itemCount: filteredDoctors.length,
          itemBuilder: (context, index) {
            final doctor = filteredDoctors[index];
            return DoctorCard(doctor: doctor);
          },
        );
      },
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailPage(doctor: doctor)
          ),
        );
      },
      child: Container(
        height:
            310, // Adjust this value as needed to increase the card's height
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular Avatar for the doctor's image
              CircleAvatar(
                radius: 40, // Adjust the radius as needed
                backgroundImage: NetworkImage(doctor.imageUrl),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 9), // Space between image and text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      doctor.getFormattedName(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      doctor.getFormattedOccupation(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 18),
                        SizedBox(width: 4),
                        Text(
                          '${doctor.ratings}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class Doctor {
  final String imageUrl;
  final String name;
  final String occupation;
  final double ratings;
  final String id; // Ensure id is a String
  final double consultationPrice; // Add consultation price
  final List<String> symptoms; // Add symptoms list
  final String about; // Add about field

  Doctor({
    required this.imageUrl,
    required this.name,
    required this.occupation,
    required this.ratings,
    required this.consultationPrice, // Add consultation price
    required this.symptoms,
    required this.about,
    required this.id, // Ensure id is a String
  });

  String getFormattedName() {
    if (name.length <= 15) {
      print("Unformatted name: $name");
      return name;
    } else {
      String formattedName =
          '${name.substring(0, 15)}...'; // Truncate to 15 characters
      print("Formatted name: $formattedName");
      return formattedName;
    }
  }

  String getFormattedOccupation() {
    if (occupation.length <= 14) {
      print("Unformatted occupation: $occupation");
      return occupation;
    } else {
      String formattedOccupation =
          '${occupation.substring(0, 14)}...'; // Truncate to 14 characters
      print("Formatted occupation: $formattedOccupation");
      return formattedOccupation;
    }
  }

  // Factory method to create Doctor from Firestore document
  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Doctor(
      imageUrl: data['imageUrl'] ?? '',
      name: data['name'] ?? '',
      occupation: data['occupation'] ?? '',
      ratings: (data['ratings'] as num).toDouble(),
      id: data['id'] ?? '', // Ensure id is a String
      consultationPrice: (data['consultationPrice'] as num).toDouble(),
      symptoms: List<String>.from(data['symptoms'] ?? []),
      about: data['about'] ?? '',
    );
  }
}

class SimpleDoctorCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon; // Added parameter for icon
  final Color iconColor; // Parameter for icon color
  final Color backgroundColor; // Parameter for background color
  final Color cardColor; // Parameter for card color

  SimpleDoctorCard({
    required this.title,
    required this.subtitle,
    this.icon = Icons.person, // Default icon if not provided
    Color? iconColor, // Optional color parameter
    Color? backgroundColor, // Optional color parameter
    Color? cardColor, // Optional card color parameter
  })  : iconColor = iconColor ?? Colors.blueGrey, // Default icon color
        backgroundColor = backgroundColor ?? Colors.blueGrey.shade100, // Default background color
        cardColor = cardColor ?? Colors.white; // Default card color

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175, // Adjust the height as needed
      width: 165, // Adjust the width as needed
      child: Card(
        color: cardColor, // Use the card color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular Container with Icon
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor, // Use the background color
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: iconColor, // Use the icon color
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
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





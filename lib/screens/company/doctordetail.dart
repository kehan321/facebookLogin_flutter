// import 'package:fbsocial/screens/company/company.dart';
// import 'package:fbsocial/screens/company/reviewcard.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fbsocial/screens/company/reviewpage.dart'; // Import your review widget

// class DoctorDetailPage extends StatelessWidget {
//   final Doctor doctor;

//   DoctorDetailPage({required this.doctor});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       endDrawer: Stack(
//         children: [
//           Positioned(
//             top: 40,
//             right: 10,
//             child: Container(
//               width: 250,
//               height: 90, // Set the desired width of the drawer
//               child: Drawer(
//                 child: Container(
//                   padding: EdgeInsets.only(top: 20), // Adjust the top padding
//                   color: Colors.grey[200], // Background color of the drawer
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Adds a line separator
//                       ListTile(
//                         title: Text('Send Feedback'),
//                         leading: Icon(Icons.feedback, color: Colors.black),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ReviewForm(doctorId: doctor.id),
//                             ),
//                           );
//                         },
//                       ),
//                       // Add more list tiles or widgets if needed
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Builder(
//         builder: (context) => Container(
//           width: MediaQuery.of(context).size.width,
//           color: Color(0xFFFFBE00),
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 40,
//                 left: 10,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back_ios_sharp, size: 30),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//               Positioned(
//                 top: 40,
//                 right: 10,
//                 child: IconButton(
//                   icon: Icon(Icons.more_vert),
//                   onPressed: () {
//                     Scaffold.of(context).openEndDrawer(); // Open the end drawer
//                   },
//                 ),
//               ),
//               Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 60),
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: NetworkImage(doctor.imageUrl),
//                       backgroundColor: Colors.transparent,
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       doctor.name,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       doctor.occupation,
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                           ),
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.call,
//                               size: 30,
//                               color: Colors.black,
//                             ),
//                             onPressed: () {
//                               // Add call action
//                             },
//                           ),
//                         ),
//                         SizedBox(width: 20),
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                           ),
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.chat,
//                               size: 30,
//                               color: Colors.black,
//                             ),
//                             onPressed: () {
//                               // Add chat action
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//               Positioned.fill(
//                 top: 320,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(22),
//                       topRight: Radius.circular(22),
//                     ),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "About Doctor",
//                           style: GoogleFonts.roboto(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           doctor.about,
//                           style: GoogleFonts.roboto(
//                             color: Colors.grey[400],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         // Integrating ReviewWidget here
//                         Text(
//                           "Patient Reviews",
//                           style: GoogleFonts.roboto(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           height: 300, // Set a fixed height for reviews
//                           child: ReviewWidget(doctorId: doctor.id), // Displaying reviews inline
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               Positioned(
//                 bottom: 6,
//                 left: 30,
//                 right: 30,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Consultation Price:"),
//                         Text(
//                           '\$${doctor.consultationPrice.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Add calculation logic
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         minimumSize: Size(
//                           MediaQuery.of(context).size.width * 0.8,
//                           70,
//                         ),
//                       ),
//                       child: Text(
//                         'Calculate',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Define the Doctor class and ReviewForm class if needed

import 'package:fbsocial/screens/company/chat.dart';
import 'package:fbsocial/screens/company/company.dart';
import 'package:fbsocial/screens/company/reviewcard.dart';
import 'package:fbsocial/screens/doctor/doctorchat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fbsocial/screens/company/reviewpage.dart'; // Import your review widget

class DoctorDetailPage extends StatefulWidget {
  final Doctor doctor;

  DoctorDetailPage({required this.doctor});

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  int reviewCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchReviewCount();
    getAverageRating();
  }

  Future<double> getAverageRating() async {
    try {
      // Reference to the 'reviews' collection in Firestore
      CollectionReference reviews =
          FirebaseFirestore.instance.collection('reviews');

      // Fetch all documents (reviews) in the collection
      QuerySnapshot querySnapshot = await reviews.get();

      // If there are no reviews, return 0 as the average rating
      if (querySnapshot.docs.isEmpty) {
        return 0.0;
      }

      double totalRating = 0.0; // To store the sum of ratings
      int totalReviews = querySnapshot.docs.length; // Total number of reviews

      // Iterate through each review to extract the rating
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        // Assuming that the rating field is stored as 'rating' in Firestore
        if (data.containsKey('rating')) {
          totalRating += data['rating']; // Add the rating to the total sum
        }
      }

      // Calculate the average rating
      double averageRating = totalRating / totalReviews;

      return averageRating;
    } catch (e) {
      print("Error fetching ratings: $e");
      return 0.0;
    }
  }

  Future<void> _fetchReviewCount() async {
    try {
      final reviewsCollection = FirebaseFirestore.instance
          .collection('reviews')
          .where('doctorId', isEqualTo: widget.doctor.id);
      final querySnapshot = await reviewsCollection.get();
      setState(() {
        reviewCount = querySnapshot.size; // Number of reviews
      });
    } catch (e) {
      print('Error fetching review count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Stack(
        children: [
          Positioned(
            top: 40,
            right: 10,
            child: Container(
              width: 250,
              height: 90,
              child: Drawer(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text('Send Feedback'),
                        leading: Icon(Icons.feedback, color: Colors.black),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReviewForm(doctorId: widget.doctor.id),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (context) => Container(
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
              Positioned(
                top: 40,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
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
                      backgroundImage: NetworkImage(widget.doctor.imageUrl),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.doctor.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.doctor.occupation,
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
                            color: Colors.white,
                          ),
                          child: IconButton(
  icon: Icon(
    Icons.call,
    size: 30,
    color: Colors.black,
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorChatPage(
          doctorId: "10",
          doctorName: "kehan",
        ),
      ),
    );
  },
)

                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.chat,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientChatPage(
                                      doctorId: widget.doctor.id,
                                      doctorName: widget.doctor.name),
                                ),
                              );
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
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Doctor",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.doctor.about,
                          style: GoogleFonts.roboto(
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Patient Reviews ($reviewCount)",
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                width:
                                    10), // Add some space between the text and rating
                            FutureBuilder<double>(
                              future:
                                  getAverageRating(), // Fetch the average rating
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // While the data is loading, show a loading indicator or placeholder
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // In case of an error, show an error message
                                  return Text("Error");
                                } else if (snapshot.hasData) {
                                  // Once the data is fetched, display the average rating
                                  return Text(
                                    " ${snapshot.data!.toStringAsFixed(1)}", // Display with one decimal place
                                    style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors
                                          .orange, // You can customize the style
                                    ),
                                  );
                                } else {
                                  return Text("No reviews");
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 150, // Set a fixed height for reviews
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                reviewCount, // Dynamic item count based on reviews length
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Width of each review card
                                // margin: EdgeInsets.symmetric(horizontal: 4), // Reduced margin for less space between cards
                                child: ReviewWidget(
                                    doctorId: widget.doctor
                                        .id), // Displaying reviews inline
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //                 Row(
                        //   children: [
                        //     Container(
                        //       width: 50,
                        //       height: 50,
                        //       decoration: BoxDecoration(
                        //         color: Colors.blue,
                        //         borderRadius: BorderRadius.circular(50),
                        //       ),
                        //       child: Icon(Icons.location_off_outlined, color: Colors.white),
                        //     ),
                        //     SizedBox(width: 10),
                        //     Text(widget.doctor.location),
                        //   ],
                        // ),

                        SizedBox(height: 100),
                      ],
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
                          '\$${widget.doctor.consultationPrice.toStringAsFixed(2)}',
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
                        backgroundColor: Colors.black,
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewWidget extends StatelessWidget {
  final String doctorId;

  ReviewWidget({required this.doctorId});

  // Fetch reviews for the specific doctor from Firestore
  Stream<List<Review>> fetchReviews() {
    print('Fetching reviews for doctorId: $doctorId'); // Debugging statement
    return FirebaseFirestore.instance
        .collection('reviews')
        .where('doctorId', isEqualTo: doctorId)  // Filter by doctorId
        .snapshots()
        .map((snapshot) {
          print('Number of documents fetched: ${snapshot.docs.length}'); // Debugging statement
          snapshot.docs.forEach((doc) {
            print('Document data: ${doc.data()}'); // Print document data
          });
          return snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Review>>(
      stream: fetchReviews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}'); // Print error for debugging
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No reviews found for doctorId: $doctorId'); // Debugging statement
          return Center(child: Text('No reviews found.'));
        } else {
          final reviews = snapshot.data!;
          print('Reviews: ${reviews.length}'); // Print the number of reviews
          reviews.forEach((review) {
            print('Review: ${review.userName}, Rating: ${review.rating}, Date: ${review.formattedDate}, Text: ${review.reviewText}');
          });
          return SizedBox(
            height: 250, // Adjusted height for horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reviews.length, // Use actual number of reviews
              itemBuilder: (context, index) {
                return Container(
                  width: 300, // Increased width for each review card
                  margin: EdgeInsets.symmetric(horizontal: 8), // Spacing between cards
                  child: ReviewCard(review: reviews[index]), // Pass the actual review object
                );
              },
            ),
          );
        }
      },
    );
  }
}

class Review {
  final String userName;
  final String reviewText;
  final String formattedDate;
  final double rating;

  Review({
    required this.userName,
    required this.reviewText,
    required this.formattedDate,
    required this.rating,
  });

  factory Review.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Review(
      userName: data['userName'] ?? 'Anonymous',
      reviewText: data['reviewText'] ?? '',
      formattedDate: data['formattedDate'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add elevation for shadow effect
      // margin: EdgeInsets.all(8), // Margin around the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                review.userName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(review.formattedDate),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text('${review.rating}'),
                ],
              ),
            ),
            SizedBox(height: 8), // Space between ListTile and review text
            Text(
              review.reviewText,
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}






class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Reviews Count',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReviewsCountPage(),
    );
  }
}

class ReviewsCountPage extends StatefulWidget {
  @override
  _ReviewsCountPageState createState() => _ReviewsCountPageState();
}

class _ReviewsCountPageState extends State<ReviewsCountPage> {
  int reviewCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchReviewCount();
  }

  Future<void> _fetchReviewCount() async {
    try {
      final reviewsCollection = FirebaseFirestore.instance.collection('reviews');
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
      appBar: AppBar(
        title: Text('Review Count'),
      ),
      body: Center(
        child: Text(
          'Number of Reviews: $reviewCount',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

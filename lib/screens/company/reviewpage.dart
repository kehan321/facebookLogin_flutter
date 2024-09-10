import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ReviewForm extends StatefulWidget {
  final String doctorId;

  ReviewForm({required this.doctorId});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  String _reviewText = '';
  double _rating = 3.0;
  bool _hasReviewed = false;

  @override
  void initState() {
    super.initState();
    _checkIfUserHasReviewed();
  }

  Future<void> _checkIfUserHasReviewed() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle user not logged in scenario
      setState(() {
        _hasReviewed = false;
      });
      return;
    }

    final userId = user.uid;
    print(
        "Checking reviews for doctorId: ${widget.doctorId} and userId: $userId");

    final reviewSnapshot = await FirebaseFirestore.instance
        .collection('reviews')
        .where('doctorId', isEqualTo: widget.doctorId)
        .where('userId', isEqualTo: userId)
        .get();

    print("Number of reviews found: ${reviewSnapshot.docs.length}");

    if (reviewSnapshot.docs.isNotEmpty) {
      setState(() {
        _hasReviewed = true;
      });
    }
  }

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Handle user not logged in scenario
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please log in to submit a review.'),
        ));
        return;
      }

      final userId = user.uid;
      final userName = user.displayName ?? 'Anonymous';
      final userProfilePic = user.photoURL ?? '';

      final now = DateTime.now();
      final formattedDate = DateFormat('yMMMd').format(now);

      await FirebaseFirestore.instance.collection('reviews').add({
        'doctorId': widget.doctorId,
        'userId': userId,
        'userName': userName,
        'userProfilePic': userProfilePic,
        'reviewText': _reviewText,
        'rating': _rating,
        'timestamp': now,
        'formattedDate': formattedDate,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Review submitted successfully!'),
      ));

      setState(() {
        _hasReviewed = true;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Form'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _hasReviewed
            ? Center(
                child: Text(
                  'You have already reviewed this doctor.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Rate this Doctor',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Write your review',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your review';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _reviewText = value!;
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Background color
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: Text('Submit Review'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

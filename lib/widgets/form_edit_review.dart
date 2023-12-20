import 'dart:convert';

import 'package:bookly_mobile/screens/edit_review.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditButton extends StatelessWidget {
  final int reviewId;
  final TextEditingController ratingController;
  final TextEditingController reviewController;

  EditButton({
    Key? key,
    required this.reviewId,
    required this.ratingController,
    required this.reviewController,
  }) : super(key: key);

  Future<void> _submitReview(BuildContext context, request) async {
    print(reviewId);
    final response = await request.postJson(
        "http://127.0.0.1:8000/review/show-reviews-specific-user/edit-review-flutter/",
        jsonEncode(<String, String>{
          'id': reviewId.toString(),
          'rating': ratingController.text,
          'reviews': reviewController.text,
        }
        )
    );
    // Handle the response here, for example, show a success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review Submitted'),
          content: Text('Your review has been updated successfully.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditReview()), // Mengarahkan ke halaman edit
            );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: ratingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Rating',
                hintText: 'Enter your rating',
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: reviewController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Review',
                hintText: 'Enter your review',
              ),
              maxLines: null, // Makes it expandable
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () => _submitReview(context, request),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xff0056ff)),
                height: 50,
                width: 280,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Color(0xff0056ff)),
                        height: 50,
                        child: const Align(
                          child: Text(
                            "Edit Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

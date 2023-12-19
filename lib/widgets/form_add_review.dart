import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  final int bookId;
  final TextEditingController ratingController;
  final TextEditingController reviewController;

  AddButton({
    Key? key,
    required this.bookId,
    required this.ratingController,
    required this.reviewController,
  }) : super(key: key);

  Future<void> _submitReview(BuildContext context, request) async {
    final response = await request.postJson(
      "http://127.0.0.1:8000/review/add-review-flutter/${this.bookId}/",
      jsonEncode(<String, dynamic>{
        'book_id': bookId,
        'rating': ratingController.text,
        'reviews': reviewController.text,
      }),
    );

    print("Response from server: ${response.body}");

    try {
      final decodedResponse = json.decode(response.body);
      // Handle the decoded response here
      print("Decoded response: $decodedResponse");
    } catch (e) {
      print("Error decoding JSON: $e");
    }
    // Handle the response here, for example, show a success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review Submitted'),
          content: Text('Your review has been added successfully.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Optionally, you can navigate to another screen after submitting
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SomeOtherScreen()),
                // );
              },
            ),
          ],
        );
      },
    );
  }

  // final request = context.watch<CookieRequest>();
  @override
  Widget build(BuildContext context) {

    final request = context.watch<CookieRequest>();

    print("halo");
    print(request.cookies);
    print("halo2");
    print(request.headers);



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
                  color: Color(0xff0056ff),
                ),
                height: 50,
                width: 280,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff0056ff),
                        ),
                        height: 50,
                        child: const Align(
                          child: Text(
                            "Add Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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

import 'package:bookly_mobile/models/book.dart';
import 'package:bookly_mobile/models/review.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  final Book book;
  final List<Review> reviews;

  const ReviewPage({
    super.key, 
    required this.book,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(book.fields.name)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          Review review = reviews[index];
          return ListTile(
            title: Text('Rating: ${review.fields.rating}'),
            subtitle: Text('Review: ${review.fields.reviews}'),
          );
        },
      ),
    );
  }
}

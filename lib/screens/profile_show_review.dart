import 'dart:collection';

import 'package:bookly_mobile/models/book.dart';
import 'package:bookly_mobile/models/review.dart';
import 'package:bookly_mobile/screens/profile_review_page.dart';
import 'package:bookly_mobile/widgets/book_card_profile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ShowReview extends StatefulWidget {
  const ShowReview({super.key});

  @override
  State<ShowReview> createState() => _ShowReviewState();
}

class _ShowReviewState extends State<ShowReview> {
  List reviews = [];
  List books = [];
  Set reviewedBooks = {};
  HashMap bookToReview = HashMap<int, List<Review>>();

  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    _initializeData(request);
  }
  
  Future<void> _initializeData(CookieRequest request) async {
    await fetchBook(request);
    await fetchReview(request);
    getReviewedBook();
    setState(() {
      // Trigger a rebuild to reflect the changes
    });
  }

  Future<void> fetchBook (CookieRequest request) async {
    var response = await request.get('http://127.0.0.1:8000/add_book/get_book/');

    List<Book> list_book = [];
    for (var d in response) {
      if (d != null) {
        list_book.add(Book.fromJson(d));
      }
    }
    books = list_book;
  }

  Future<void> fetchReview (CookieRequest request) async {
    var response = await request.get('http://127.0.0.1:8000/review/get-review-json-by-user-id/');
    print("\nRESPONSE REVIEW ==> ${response.toString()}\n");

    List<Review> list_review = [];
    for (var d in response) {
      if (d != null) {
        list_review.add(Review.fromJson(d));
      }
    }
    reviews = list_review;
  }

  void getReviewedBook () {
    for (int i = 0; i < reviews.length; i++) {
      Review review = reviews[i];
      for (int j = 0; j < books.length; j++) {
        Book book = books[j];
          if (review.fields.book == book.pk) {
            reviewedBooks.add(book);
            if (bookToReview.containsKey(book.pk)) {
              bookToReview[book.pk].add(review);
            }
            else {
              bookToReview[book.pk] = [review];
            }
          }
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    // getReviewedBook();
    print("BUKU YANG SUDAH DI REVIEW ==>  ${reviewedBooks}");
    print("BUKU DAN REVIEW ==>  ${bookToReview}");

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Review Page'),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: reviewedBooks.length,
        itemBuilder: (context, index) {
          Book book = reviewedBooks.elementAt(index);
          return BookCardProfile(
            book: book,
            onTap: () {
              navigateToReviewPage(book);
            },
          );
        },
      ),
    );
  }

  void navigateToReviewPage(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewPage(
          book: book,
          reviews: bookToReview[book.pk] ?? [],
        ),
      ),
    );
  }
}
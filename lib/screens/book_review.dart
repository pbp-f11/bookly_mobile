// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:bookly_mobile/models/review.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

// class BookReviewPage extends StatefulWidget {
//   const BookReviewPage({Key? key}) : super(key: key);

//   @override
//   _BookReviewPage createState() => _BookReviewPage();
// }

// class _BookReviewPage extends State<BookReviewPage> {
  
//   @override
//   void initState() {
//     super.initState();
//     _loadReview();
//   }

//   Future<List<Review>> fetchReview() async {
//     var url = Uri.parse('http://localhost:8000/get-user-review/');
//     var response = await http.get(
//       url,
//       headers: {"Content-Type": "application/json"},
//     );

//     // melakukan decode response menjadi bentuk json
//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     List<Review> list_review = [];
//     for (var d in data) {
//       if (d != null) {
//         list_review.add(Review.fromJson(d));
//       }
//     }
//     return list_review;
//   }
  
//   Future<void> _loadReview() async {
//     List<Review> reviews = await fetchReview();
//     print("KEBACA KAH REVIEWNYA???");
//     print(reviews);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text('Book & Review'),
//         ),
//         backgroundColor: Colors.indigo,
//         foregroundColor: Colors.white,
//       ),
//     );
//   }
  
// }
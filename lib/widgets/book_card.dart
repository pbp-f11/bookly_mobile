import 'package:bookly_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookly_mobile/models/book.dart';
import 'package:bookly_mobile/models/review.dart';

import 'package:bookly_mobile/screens/add_review.dart';




// class ShopItem {
//   final String name;
//   final IconData icon;
//   final Color color;
//
//   ShopItem(this.name, this.icon, this.color);
// }

class BookCard extends StatelessWidget {
  final Book item;

  BookCard(this.item); // Removed the 'review' parameter

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: Colors.indigo,
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("You pressed ${item.fields.name}!")));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReview(bookId: item.pk, book: item), // Pass item.pk as bookId
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.fields.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

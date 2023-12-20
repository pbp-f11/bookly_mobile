import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookly_mobile/models/book.dart';
import 'package:bookly_mobile/screens/add_review.dart';

class BookCard extends StatelessWidget {
  final Book item;

  BookCard(this.item);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("You pressed ${item.fields.name}!")));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReview(bookId: item.pk, book: item),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = 18.0;
              if (constraints.maxWidth < 200) {
                fontSize = 14.0; // Atur ukuran font minimum
              } else if (constraints.maxWidth < 300) {
                fontSize = 16.0; // Atur ukuran font medium
              }

              return Text(
                item.fields.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

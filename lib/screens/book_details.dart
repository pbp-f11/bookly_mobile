import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bookly_mobile/models/book.dart';
import 'package:bookly_mobile/widgets/left_drawer.dart';
import 'package:bookly_mobile/screens/add_review.dart';
import 'package:bookly_mobile/widgets/form_edit_book.dart';
import 'package:bookly_mobile/screens/menu.dart';
import 'dart:convert';

class BookDetails extends StatefulWidget {
  final int bookId;
  final Book book;

  const BookDetails({Key? key, required this.bookId, required this.book}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  late Future<Book> _bookDetailsFuture;

  @override
  void initState() {
    super.initState();
    _bookDetailsFuture = fetchBookDetails();
  }

  Future<Book> fetchBookDetails() async {
    var response = await http.get(
      Uri.parse('https://bookly-f11-tk.pbp.cs.ui.ac.id/edit_book/get_book_json/${widget.bookId}'),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load book');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              child: Icon(Icons.arrow_back), // Tombol back
            ),
            SizedBox(width: 8), // Jarak antara tombol dan judul
            Text('Book Details'), // Judul
          ],
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<Book>(
        future: _bookDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Book not found'));
          } else {
            // Display the book details
            final book = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBookTitle(widget.book.fields.name),
                  SizedBox(height: 16.0),
                  _buildDetailRow('Author', widget.book.fields.author),
                  _buildDetailRow('Rating', widget.book.fields.rating.toString()),
                  _buildDetailRow('Price', widget.book.fields.price.toString()),
                  _buildDetailRow('Year', widget.book.fields.year.toString()),
                  SizedBox(height: 24.0),
                  Divider(color: Colors.indigo),
                  SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildEditButton(context),
                        SizedBox(width: 8.0),
                        _buildShowReviewsButton(context),
                        SizedBox(width: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildBookTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 4.0),
        Text(
          label == 'Price' ? '$value \$' : value,
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditBookPage(book: widget.book),
          ),
        );
      },
      child: Text('Edit Book'),
    );
  }

  Widget _buildShowReviewsButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddReview(bookId: widget.bookId, book: widget.book),
          ),
        );
      },
      child: Text('Show Reviews'),
    );
  }
}

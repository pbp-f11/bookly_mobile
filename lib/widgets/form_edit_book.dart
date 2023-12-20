import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookly_mobile/models/book.dart';
import 'package:bookly_mobile/screens/book_details.dart';

class EditBookPage extends StatefulWidget {
  final Book book;

  EditBookPage({required this.book});

  @override
  _EditBookPageState createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the book data
    _titleController.text = widget.book.fields.name;
    _authorController.text = widget.book.fields.author;
    _priceController.text = widget.book.fields.price.toString();
    _yearController.text = widget.book.fields.year.toString();
  }

  Future<void> updateBook(BuildContext context) async {
    final apiUrl =
        Uri.parse('http://127.0.0.1:8000/edit_book/edit_book_flutter/${widget.book.pk}');

    final response = await http.put(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': _titleController.text,
        'author': _authorController.text,
        'price': _priceController.text,
        'year': _yearController.text,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        widget.book.fields.name = _titleController.text;
        widget.book.fields.author = _authorController.text;
        widget.book.fields.price = int.parse(_priceController.text);
        widget.book.fields.year = int.parse(_yearController.text);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Yeeay, Book updated'),
        ),
      );
      Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetails(
                bookId: widget.book.pk,
                book: widget.book,
              ),
            ),
          );
    } else {
      // Gagal menyimpan perubahan
      // Tambahkan logika atau pesan kesalahan di sini
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Book Gagal'),
            content: Text('Gagal menyimpan perubahan: ${response.body}'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      print('Response Body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter book title',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Author',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  hintText: 'Enter author name',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Price',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: 'Enter book price',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Year',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  hintText: 'Enter publication year',
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman detail buku
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updateBook(context);
                    },
                    child: Text('Save Changes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

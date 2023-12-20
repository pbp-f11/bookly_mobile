import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController authorController;
  final TextEditingController priceController;
  final TextEditingController yearController;
  final TextEditingController genreController;

  AddButton({
    Key? key,
    required this.nameController,
    required this.authorController,
    required this.priceController,
    required this.yearController,
    required this.genreController,
  }) : super(key: key);

  Future<void> _submitBook(BuildContext context, request) async {
    final response = await request.postJson(
      "http://localhost:8000/book/add-book-flutter/",
      jsonEncode(<String, String>{
        'name': nameController.text,
        'author': authorController.text,
        'year': yearController.text,
        'genre': genreController.text,
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
          title: const Text('Book Submitted'),
          content: const Text('Your book has been added successfully.'),
          actions: [
            TextButton(
              child: const Text('OK'),
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
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your book name',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: authorController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Author',
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
                hintText: 'Enter your book price',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Year',
                hintText: 'Enter your publish year',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: genreController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Genre',
                hintText: 'Enter your genre',
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _submitBook(context, request),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xff0056ff),
                ),
                height: 50,
                width: 280,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: const Color(0xff0056ff),
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

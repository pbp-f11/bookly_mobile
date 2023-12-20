import 'package:bookly_mobile/widgets/left_drawer.dart';
import 'package:bookly_mobile/widgets/shop_card.dart';
import 'package:bookly_mobile/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:bookly_mobile/models/book.dart';
import 'dart:convert';
import  'dart:core';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  List<Book> listProduct = [];

  MyHomePage({Key? key}) : super(key: key);

  Future<List<Book>> fetchProduct(request) async {
    try {
      var response = await request.get(
        'http://127.0.0.1:8000/add_book/get_book/',
      );

      print('Response type: ${response.runtimeType}');

      if (response is List<dynamic>) {
        // Assuming your response is a List<dynamic>
        // Parse the response JSON
        List<dynamic> jsonResponse = response;

        // Create a list of Book objects from the parsed JSON
        List<Book> listProduct = jsonResponse.map((data) => Book.fromJson(data)).toList();

        return listProduct;
      } else {
        // Log the response and throw an exception
        print('Unexpected response type: ${response.runtimeType}');
        throw Exception('Invalid response type. Expected List<dynamic>.');
      }
    } catch (error) {
      // Handle errors, log them, and throw the exception again
      print('Error fetching products: $error');
      throw Exception('Failed to load products. Error: $error');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookly'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Use the fetched data to build the UI
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        'Bookly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      children: (snapshot.data as List<Book>).map((item) {
                        return BookCard(item);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

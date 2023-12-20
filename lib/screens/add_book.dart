import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:bookly_mobile/models/book.dart';

import 'package:bookly_mobile/widgets/left_drawer.dart';
import 'package:bookly_mobile/widgets/add_book_card.dart';
import 'package:bookly_mobile/widgets/form_add_book.dart';

import 'dart:convert';

class AddBook extends StatefulWidget {
  final Book book;

  const AddBook({Key? key, required this.book}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {

  Future<List<Book>> fetchProduct(request) async {
    var response = await request.get(
      'http://127.0.0.1:8000/book/get-book/',
    );

    List<Book> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(Book.fromJson(d));
      }
    }
    print(listProduct);
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {

    var name =  widget.book.fields.name;
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: Color(0xFFF3F5F9),
      appBar: AppBar(
        title: Text('Books of ${name}'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          ElevatedButton(
            onPressed: () {
              print("Button pressed");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddButton(
                    nameController: TextEditingController(),
                    authorController: TextEditingController(),
                    priceController: TextEditingController(),
                    yearController: TextEditingController(),
                    genreController: TextEditingController(),
                  ),
                ),
              );
            },
            child: Text("Add New Book"),
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Column(
            children: [
              FutureBuilder(
                future: fetchProduct(request),
                builder: (context, AsyncSnapshot<List<Book>> snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Column(
                        children: [
                          Text(
                            "Tidak ada data produk.",
                            style: TextStyle(
                                color: Color.fromARGB(255, 89, 91, 216), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(height: 28.0),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 28.0),
                                    child: AddBookCard(book: snapshot.data![index]),
                                  ),
                                  SizedBox(height: 40),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ]
        )
      )
    );
  }
}

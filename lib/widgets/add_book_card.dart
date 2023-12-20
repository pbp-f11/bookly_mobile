import 'dart:convert';

import 'package:bookly_mobile/models/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddBookCard extends StatefulWidget {
  final Book book;

  const AddBookCard({super.key, required this.book});

  @override
  State<AddBookCard> createState() => _AddBookCardState();
}





class _AddBookCardState extends State<AddBookCard> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    double fem = 1.0;
    double ffem = 1.0;


    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20 * fem),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(18, 16.5 , 18, 16.5),
            width: double.infinity,
            height: 60 * fem,
            decoration: BoxDecoration(
              color: Color(0xffdce3fb),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'asset/img/Star.png',
                  width: 26.67 * fem,
                  height: 25.34 * fem,
                ),
                SizedBox(width: 14.66 * fem),
                Text(
                  'Rating: ${widget.book.fields.rating}',
                  style: TextStyle(
                    fontSize: 18 * ffem,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 17 * fem),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0 * fem, 18 * fem, 0 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.book.fields.name,
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff696969),
                  ),
                ),
                Text(
                  widget.book.fields.author,
                  style: TextStyle(
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff989898),
                  ),
                ),
                Text(
                  '${widget.book.fields.genre}',
                  style: TextStyle(
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff989898),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 17 * fem),
          Container(
            padding: EdgeInsets.fromLTRB(16 * fem, 11 * fem, 16 * fem, 14 * fem),
            width: double.infinity,
            height: 76 * fem,
            decoration: BoxDecoration(
              color: Color(0xffdce3fb),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              ],
            ),
          ),
        ],
      ),
    );
  }
}

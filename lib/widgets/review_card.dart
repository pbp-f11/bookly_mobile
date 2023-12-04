import 'dart:convert';

import 'package:bookly_mobile/screens/edit_review.dart';
import 'package:flutter/material.dart';
import 'package:bookly_mobile/models/edit_review_models.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewCard extends StatefulWidget {
  final EditReviewM review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}


Future<void> _deletereview (BuildContext context, CookieRequest request,  EditReviewM review) async {
  await request.postJson(
      'http://127.0.0.1:8000/review/show-reviews-specific-user/delete-item-flutter',
      jsonEncode({
        "review_id": review.pk
      }));
}

class _ReviewCardState extends State<ReviewCard> {
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
                  'Rating: ${widget.review.fields.rating}',
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
            margin: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 18 * fem, 0 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.review.fields.reviews,
                  style: TextStyle(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff696969),
                  ),
                ),
                Text(
                  '- ${widget.review.fields.user}',
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
                Expanded(
                  child: TextButton(
                    
                    onPressed: () {
                      // Fungsi untuk edit
                    },
                    style: TextButton.styleFrom(
                      
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 140 * fem,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff0056ff),
                        borderRadius: BorderRadius.circular(20 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 7 * fem),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      _deletereview(context, request, widget.review);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 140 * fem,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffff2a2a),
                        borderRadius: BorderRadius.circular(20 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

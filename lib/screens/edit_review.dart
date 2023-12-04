import 'package:bookly_mobile/models/edit_review_models.dart';
import 'package:bookly_mobile/widgets/left_drawer.dart';
import 'package:bookly_mobile/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EditReview extends StatefulWidget {
  const EditReview({super.key});

  @override
  State<EditReview> createState() => _EditReviewState();
}

class _EditReviewState extends State<EditReview> {
  Future<List<EditReviewM>> fetchProduct(request) async {
    var response = await request.get(
      'http://127.0.0.1:8000/review/get-review-json-by-user-id/',
    );

    List<EditReviewM> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(EditReviewM.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: Color(0xFFF3F5F9),
      appBar: AppBar(
        title: const Text(
          'Edit Review',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot<List<EditReviewM>> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return Stack(
                children: [
                  ListView(
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
                              padding: const EdgeInsets.symmetric(horizontal: 28.0),
                              child: ReviewCard(review: snapshot.data![index]),
                            ),
                            SizedBox(height: 40), 
                          ],
                        );
                      },
                    ),
                    ],
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

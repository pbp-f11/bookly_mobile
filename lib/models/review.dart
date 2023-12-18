// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) => List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  String model;
  int pk;
  Fields fields;

  Review({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  List<String> user;
  int book;
  DateTime dateAdded;
  int rating;
  String reviews;

  Fields({
    required this.user,
    required this.book,
    required this.dateAdded,
    required this.rating,
    required this.reviews,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: List<String>.from(json["user"].map((x) => x)),
    book: json["book"],
    dateAdded: DateTime.parse(json["date_added"]),
    rating: json["rating"],
    reviews: json["reviews"],
  );

  Map<String, dynamic> toJson() => {
    "user": List<dynamic>.from(user.map((x) => x)),
    "book": book,
    "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
    "rating": rating,
    "reviews": reviews,
  };
}

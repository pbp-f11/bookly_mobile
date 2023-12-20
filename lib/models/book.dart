// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  int pk;
  Model model;
  Fields fields;

  Book({
    required this.pk,
    required this.model,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    pk: json["pk"],
    model: modelValues.map[json["model"]]!,
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "model": modelValues.reverse[model],
    "fields": fields.toJson(),
  };
}

class Fields {
  String name;
  String author;
  double? rating;
  int? reviews;
  int? price;
  int? year;
  Genre genre;

  Fields({
    required this.name,
    required this.author,
    this.rating,
    this.reviews,
    this.price,
    this.year,
    required this.genre,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    name: json["name"] ?? "", // Provide a default value or handle differently for null
    author: json["author"] ?? "", // Provide a default value or handle differently for null
    rating: json["rating"]?.toDouble(),
    reviews: json["reviews"] as int? ?? 0,
    price: json["price"] as int? ?? 0,
    year: json["year"] as int? ?? 0,
    genre: genreValues.map[json["genre"]] ?? Genre.FICTION, // Provide a default value for null
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "author": author,
    "rating": rating,
    "reviews": reviews,
    "price": price,
    "year": year,
    "genre": genreValues.reverse[genre],
  };
}

enum Genre {
  FICTION,
  NON_FICTION
}

final genreValues = EnumValues({
  "Fiction": Genre.FICTION,
  "Non Fiction": Genre.NON_FICTION
});

enum Model {
  BOOK_BOOK
}

final modelValues = EnumValues({
  "book.book": Model.BOOK_BOOK
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

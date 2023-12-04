import 'dart:convert';

List<EditReviewM> editReviewMFromJson(String str) => List<EditReviewM>.from(json.decode(str).map((x) => EditReviewM.fromJson(x)));

String editReviewMToJson(List<EditReviewM> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EditReviewM {
    String model;
    int pk;
    Fields fields;

    EditReviewM({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory EditReviewM.fromJson(Map<String, dynamic> json) => EditReviewM(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

  get user => null;

  get reviews => null;

  get rating => null;

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

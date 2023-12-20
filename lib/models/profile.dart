// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

// Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
List<Profile> profileFromJson(String str) => List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));
String profileToJson(List<Profile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
    String model;
    int pk;
    Fields fields;

    Profile({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
    int user;
    String email;
    String firstName;
    String lastName;
    String address;
    String phoneNumber;
    String gender;

    Fields({
        required this.user,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.address,
        required this.phoneNumber,
        required this.gender,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        email: json["email"] ?? '',
        firstName: json["first_name"]?? '',
        lastName: json["last_name"]?? '',
        address: json["address"]?? '',
        phoneNumber: json["phone_number"]?? '',
        gender: json["gender"]?? '',
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "phone_number": phoneNumber,
        "gender": gender,
    };
}
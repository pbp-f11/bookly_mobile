import 'package:bookly_mobile/screens/profile_show_review.dart';
import 'package:flutter/material.dart';
import 'package:bookly_mobile/models/profile.dart';
import 'package:bookly_mobile/screens/menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookly_mobile/screens/login.dart' as loginUsername;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController(text: loginUsername.AppData.formController.usernameController.text);
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController= TextEditingController();
  TextEditingController _addressController= TextEditingController();
  TextEditingController _genderController= TextEditingController();

  String _gender = '';
  String _username = '';
  String _firstName = '';
  String _lastName = '';
  String _address = '';
  String _phoneNumber = '';
  String _email = '';

  Future<void> fetchProfile(CookieRequest request) async {
    var response = await request.get('http://127.0.0.1:8000/profile-json/');
    
    print('RESPONSE => ${response.toString()}');
    
    List<Profile> list_profile = [];
    for (var d in response) {
      list_profile.add(Profile.fromJson(d));
    }
    
    var profile = list_profile[0].fields;
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _emailController.text = profile.email;
    _phoneNumberController.text = profile.phoneNumber;
    _addressController.text = profile.address;
    _genderController.text = profile.gender;

    _firstName = profile.firstName;
    _lastName = profile.lastName;
    _email = profile.email;
    _phoneNumber = profile.phoneNumber;
    _address = profile.address;
    _gender = profile.gender;
  }

  @override
  void initState() {
    super.initState();
    final request = context.read<CookieRequest>();
    fetchProfile(request);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Profile Page'),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form (
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: _usernameController,
                    decoration: InputDecoration(
                        hintText: "Username",
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller:_firstNameController,
                    decoration: InputDecoration(
                        hintText: "First Name",
                        labelText: "First Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    onChanged: (String? value) {
                      setState(() {
                        _firstName = value!;
                      });
                    },
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        hintText: "Last Name",
                        labelText: "Last Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    onChanged: (String? value) {
                      setState(() {
                        _lastName = value!;
                      });
                    },
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    validator: (value) {
                      String emailRegex = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
                      RegExp regex = RegExp(emailRegex);

                      if (!regex.hasMatch(value!)) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        _email = value!;
                      });
                    },
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        labelText: "Phone Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != '') {
                        try {
                          double.parse(value!);
                        }
                        catch (e) {
                          return 'Field hanya menerima angka';
                        }
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        _phoneNumber = value!;
                      });
                    },
                  ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Gender",
                    labelText: "Gender",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _gender,
                  items: ['', "Male", "Female"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        hintText: "Address",
                        labelText: "Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      setState(() {
                        _address = value!;
                      });
                    },
                  ),
              ),

              const SizedBox(height: 10.0),

              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.indigo)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Kirim ke Django dan tunggu respons
                              final response = await request.postJson(
                                  "http://127.0.0.1:8000/update-profile/",
                                  jsonEncode(<String, String>{
                                    'email': _email,
                                    'first_name': _firstName,
                                    'last_name': _lastName,
                                    'address': _address,
                                    'phone_number': _phoneNumber,
                                    'gender': _gender
                                  }));
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Profil berhasil diperbarui!"),
                                ));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Terdapat kesalahan, silakan coba lagi."),
                                ));
                              }
                            }
                          },
                          child: const Text(
                            "Save Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        const SizedBox(width: 16.0),

                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.indigo)
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowReview(),
                              ),
                            );
                          }, 
                          child: const Text(
                            "See Review",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      )
    );
  }
}
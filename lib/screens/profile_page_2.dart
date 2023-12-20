import 'package:flutter/material.dart';
import 'package:bookly_mobile/models/profile.dart';
import 'package:bookly_mobile/screens/menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookly_mobile/screens/login.dart' as loginUsername;
import 'package:bookly_mobile/screens/register.dart' as registerUsername;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  State<ProfileFormPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController(text: loginUsername.AppData.formController.usernameController.text);
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _addressController;
  late TextEditingController _genderController;

  // String usernameLogin = AppData.formController.usernameController.text;
  // String usernameLogin = loginUsername.AppData.formController.usernameController.text;

  String _gender = '';
  String _username = '';
  String _firstName = '';
  String _lastName = '';
  String _address = '';
  String _phoneNumber = '';
  String _email = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _loadProfileData();
  // }

  Future<void> _loadProfileData(request) async {
    try {

      List<Profile> profile = await fetchProfile(request);

      // _usernameController = TextEditingController(text: usernameLogin);
      _firstNameController =
          TextEditingController(text: profile[0].fields.firstName);
      _lastNameController =
          TextEditingController(text: profile[0].fields.lastName);
      _emailController = TextEditingController(text: profile[0].fields.email);
      _phoneNumberController =
          TextEditingController(text: profile[0].fields.phoneNumber);
      _addressController =
          TextEditingController(text: profile[0].fields.address);
      _genderController = TextEditingController(text: profile[0].fields.gender);

      // if (mounted) {
      //   setState(() {});
      // }
    } catch (e) {
      print('Failed to fetch data from web app: $e');
    }
  }

  // Future<List<User>> fetchUser() async {
  //   print("FETCH USER DATA");
  //   var url = Uri.parse('http://localhost:8000/user-json/');
  //   var response = await http.get(
  //     url,
  //     headers: {"Content-type": "application/json"},
  //   );
  //   var data = jsonDecode(utf8.decode(response.bodyBytes));
  //   List<User> list_user = [];
  //   for (var d in data) {
  //     list_user.add(User.fromJson(d));
  //   }
  //   print("RESULT FROM FETCH USER: ");
  //   print(list_user);
  //   for (int i = 0; i < list_user.length; i++) {
  //     if (list_user[i].fields.username == usernameLogin) {
  //       print("OBJECT AQUIRED -> ${list_user[i].fields.username}");
  //     }
  //   }
  //   return list_user;
  // }

  Future<List<Profile>> fetchProfile(request) async {
    print("FETCH PROFILE DATA");
    var url = Uri.parse('http://localhost:8000/profile-json/');
    var response = await request.get(
      url
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Profile> list_profile = [];
    for (var d in data) {
      list_profile.add(Profile.fromJson(d));
    }

    print("RESULT FROM FETCH PROFILE:");
    print(list_profile);

    return list_profile;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    _loadProfileData(request);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Profile Page'),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
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
                    // onChanged: (String? value) {
                    //   setState(() {
                    //     _username = value!;
                    //   });
                    // },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Username tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _firstNameController,
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "First Name tidak boleh kosong";
                      }
                      return null;
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Last Name tidak boleh kosong";
                      }
                      return null;
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
                    onChanged: (String? value) {
                      setState(() {
                        _lastName = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Email tidak boleh kosong";
                      }
                      return null;
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
                    onChanged: (String? value) {
                      setState(() {
                        _phoneNumber = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Phone Number tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Phone Number harus berupa angka";
                      }
                      return null;
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Gender tidak boleh kosong";
                      }
                      return null;
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
                    onChanged: (String? value) {
                      setState(() {
                        _address = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Address tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Kirim ke Django dan tunggu respons
                          // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                          final response = await request.postJson(
                              "http://localhost:8000/update-profile/",
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
                              content: Text("Produk baru berhasil disimpan!"),
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
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

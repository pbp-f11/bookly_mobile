import 'package:bookly_mobile/screens/edit_review.dart';
import 'package:bookly_mobile/screens/login.dart';
import 'package:bookly_mobile/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:bookly_mobile/screens/add_review.dart'; //just test

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});
  
  get request => null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Bookly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Let's read a book!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.edit),
          //   title: const Text('Add Review'), // just testing
          //   onTap: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => AddReview(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Review'),
            onTap: () {
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EditReview(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
               Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              
              logoutProcess(context);
            },
          ),
        ],
      ),
    );
  }

  void logoutProcess(BuildContext context) async {
  final response =
      await request.logout("http://127.0.0.1:8000/auth/logout/");
  String message = response["message"];
  if (response['status']) {
    String uname = response["username"];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message Sampai jumpa, $uname."),
    ));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message"),
    ));
  }
  }
}

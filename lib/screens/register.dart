import 'package:bookly_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = AppData.formController.usernameController;
  final TextEditingController _passwordController = AppData.formController.passwordController;
  final TextEditingController _passwordConfirmationController = AppData.formController.passwordConfirmationController;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    // change the icon based on the password visibility
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // password visibility state
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_passwordVisible,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordConfirmationController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    // change the icon based on the password visibility
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // password visibility state
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_passwordVisible,
            ),
            const SizedBox(height: 18.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;
                String passwordConfirmation =
                    _passwordConfirmationController.text;

                // Perform input validation
                if (username.isEmpty ||
                    password.isEmpty ||
                    passwordConfirmation.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Registration Failed'),
                      content: const Text('Please fill in all fields.'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                  return;
                }

                if (password != passwordConfirmation) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Registration Failed'),
                      content: const Text('Passwords do not match.'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                  return;
                }
                // Registration logic, send registration request to your server API
                final response = await http.post(
                  Uri.parse('http://localhost:8000/auth/register/'),
                  body: {
                    'username': username,
                    'password1': password,
                    'password2': passwordConfirmation,
                  },
                );

                if (response.statusCode == 201) {
                  // Registration successful
                  String message =
                      'Registration successful. Please Log in';
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(message),
                    ));
                } else {
                  // Registration failed
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Registration Failed'),
                      content: const Text(
                          'Registration failed. Please try again later.'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Sudah Punya Akun?",
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage()), // Navigate to login page
                );
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 14.0,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
}

class AppData {
  static final FormController formController = FormController();
}
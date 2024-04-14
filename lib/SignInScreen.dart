import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:openlibrary/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _registrationNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  String? _validateRegistrationNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your registration number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('http://172.20.10.2/api/login');

      final headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
      };

      final body = {
        'reg_no': _registrationNumberController.text,
        'password': _passwordController.text,
      };

      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

          log("response: ${response.body}");

      if (response.statusCode == 200) {
        final response_data = jsonDecode(response.body);
        final token = response_data['data']['token'];
        final user = response_data['data']['user'];

        // Save the token and user details to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('user', jsonEncode(user));

        // Navigate to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('UICT Open Library'),
      backgroundColor: Color.fromARGB(235, 3, 41, 67),
    ),
    body: SingleChildScrollView( // Wrap with SingleChildScrollView
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.0),
              Image.asset(
                'assets/logo.png',
                height: 180,
              ),
              SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _registrationNumberController,
                      decoration: InputDecoration(
                        labelText: 'Reg Number/Email',
                      ),
                      validator: _validateRegistrationNumber,
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: _validatePassword,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                        Text('Remember me'),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                      child: Container(
                        color: Color.fromARGB(255, 8, 11, 43),
                        child: ElevatedButton(
                          onPressed: _login,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(235, 3, 41, 67),
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
        ),
      ),
    ),
  );
}

}

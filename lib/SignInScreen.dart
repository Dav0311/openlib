import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:openlibrary/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

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
    // Validate the form
    if (_formKey.currentState!.validate()) {
      final registrationNumber = _registrationNumberController.text;
      final password = _passwordController.text;

      try {
        // Sign in the user with Firebase Authentication
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: registrationNumber, password: password);

        // Check if the login was successful
        if (userCredential.user != null) {
          // Successful login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logged in successfully')),
          );

          // Navigate to the home screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
          );
        } else {
          // Failed login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed')),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase Authentication errors here
        print('Firebase Authentication Error: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.message}')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    
    initializeFirebase ();

  }

  Future <void> initializeFirebase () async {
    try{
      await Firebase.initializeApp();
      print("initialisation successful");
    } catch (error){
      print("initialisation error : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UICT Open Library'),
        backgroundColor: Color.fromARGB(235, 3, 41, 67),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.0),
              Image.asset(
                '/Users/ronaldjjingo/Desktop/Development/openlibraryf/openlibrary/assets/logo.png',
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
                            style: TextStyle(
                                color: Colors.white),
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
    );
  }
}

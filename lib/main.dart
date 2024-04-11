import 'package:flutter/material.dart';
import 'package:openlibrary/HomeScreen.dart';
import 'package:openlibrary/SignInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _determineInitialRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // return Text('Error: ${snapshot.error}');
            return const Center(
              child: Text("An error occurred. Please try again later"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // return const Text('No data available');
            return const Center(
              child: Column(
                children: [
                  Text("No data available"),
                ],
              ),
            );
          } else {
            return MaterialApp(
              routes: {
                '/SignInScreen': (context) => SignInScreen(),
                '/HomeScreen': (context) => HomeScreen(),
              },
              debugShowCheckedModeBanner: false,
              initialRoute: snapshot.data ?? '/SignInScreen',
            );
          }
        });
  }

  // Check if there is a token in the shared preferences
  Future<String> _determineInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null ? '/HomeScreen' : '/SignInScreen';
  }
}

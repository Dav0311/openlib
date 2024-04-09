import 'package:flutter/material.dart';
import 'SignInScreen.dart';
import 'HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkModeEnabled = false;

  // Function to sign out and navigate to the login screen
  void _signOut(BuildContext context) {
    // Add your sign out logic here (e.g., clearing user data, token, etc.)

    // Navigate to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromARGB(235, 3, 41, 67),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the "HomeScreen" (you can replace with your actual screen name)
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          buildListTile(
            title: 'My Account',
            onTap: () {
              // Handle My Account option tap
            },
          ),
          buildListTile(
            title: 'Updates',
            onTap: () {
              // Handle Updates option tap
            },
          ),
          buildListTile(
            title: 'Books',
            onTap: () {
              // Handle Books option tap
            },
          ),
          buildListTile(
            title: 'Bookmarks',
            onTap: () {
              // Handle Notifications option tap
            },
          ),
          buildListTile(
            title: 'Downloaded',
            onTap: () {
              // Handle Downloaded option tap
            },
          ),
          buildListTile(
            title: 'Notifications',
            onTap: () {
              // Handle Notifications option tap
            },
          ),
          buildListTile(
            title: 'Support',
            onTap: () {
              // Handle Notifications option tap
            },
          ),
          buildDarkModeSwitch(),
          buildListTile(
            title: 'Sign Out',
            onTap: () {
              // Call the _signOut function to sign out and navigate to the login screen
              _signOut(context);
            },
          ),
        ],
      ),
    );
  }

  ListTile buildListTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget buildDarkModeSwitch() {
    return ListTile(
      title: Text('Dark Mode Theme'),
      trailing: Switch(
        value: isDarkModeEnabled,
        onChanged: (value) {
          setState(() {
            isDarkModeEnabled = value;
          });
          // Update the theme based on the toggle state
          if (isDarkModeEnabled) {
            // Set dark theme
            // ThemeMode.dark;
          } else {
            // Set light theme
            // ThemeMode.light;
          }
        },
      ),
    );
  }
}

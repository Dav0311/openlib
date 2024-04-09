import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:openlibrary/HomeScreen.dart';
import 'package:openlibrary/courseScreens/BusAdmin.dart';
import 'package:openlibrary/courseScreens/ComEngineer.dart';
import 'package:openlibrary/courseScreens/ComputerScience.dart';
import 'package:openlibrary/courseScreens/Electrical.dart';
import 'package:openlibrary/courseScreens/InfoTech.dart';
import 'MyBooksScreen.dart';
import 'courseScreens/ICTDiploma.dart';
import 'SignInScreen.dart';
import 'SettingsScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/SignInScreen': (context) => SignInScreen(), // Set SignInScreen as the initial route
        '/HomeScreen': (context) => HomeScreen(),
        '/MyBooksScreen': (context) => MyBooksScreen(),
        '/SettingsScreen': (context) => SettingsScreen(),
        '/ICTDiplomaScreen': (context) =>
            ICTDiplomaScreen(pdfPath: '/Users/ronaldjjingo/Desktop/Development/openlibraryf/openlibrary/assets/Apis.pdf'),
        '/ComEngineerScreen': (context) =>
            ComEngineerScreen(pdfPath: '/Users/ronaldjjingo/Desktop/Development/openlibraryf/openlibrary/assets/Com.pdf',),
        '/ElectricalScreen': (context) =>
            ElectricalScreen(pdfPath: '/Users/ronaldjjingo/Desktop/Development/openlibraryf/openlibrary/assets/data.pdf'),
        '/ComputerScienceScreen': (context) =>
            ComputerScienceScreen(pdfPath: '/Users/ronaldjjingo/Desktop/Development/openlibraryf/openlibrary/assets/SQL.pdf',),
        '/InfoTechScreen': (context) =>
            InfoTechScreen(pdfPath: '/Users/ronaldjjingo/Desktop/Development/openlibraryf/openlibrary/assets/C.pdf',),
        '/BusAdminScreen': (context) =>
            BusAdminScreen(pdfPath: '/Users/ronaldjjingo/Desktop/Development/openlibraryf/openlibrary/assets/buz.pdf',),
      },
      initialRoute: '/SignInScreen', // Set SignInScreen as the initial route
    );
  }
}

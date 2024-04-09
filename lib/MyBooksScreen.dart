import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyBooksScreen(),
  ));
}

class MyBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
        backgroundColor: Color.fromARGB(235, 3, 41, 67),
      ),
     // body: DocumentsList(), // Use the DocumentsList widget to display PDFs
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 1, // Set the current index for My Books
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/HomeScreen'); // Navigate to HomeScreen
              break;
            case 1:
              // Do nothing, already on My Books
              break;
            case 2:
              Navigator.pushNamed(context, '/SettingsScreen'); // Navigate to SettingsScreen
              break;
          }
        },
      ),
    );
  }
}


import 'package:flutter/material.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
        backgroundColor: const Color.fromARGB(235, 3, 41, 67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          buildListTile(
            title: 'Book 1',
            onTap: () {
              // Handle Book 1 tap
            },
          ),
          buildListTile(
            title: 'Book 2',
            onTap: () {
              // Handle Book 2 tap
            },
          ),
          buildListTile(
            title: 'Book 3',
            onTap: () {
              // Handle Book 3 tap
            },
          ),
          buildListTile(
            title: 'Book 4',
            onTap: () {
              // Handle Book 4 tap
            },
          ),
        ],
      ),
    );
  }
  
  buildListTile({required String title, required Null Function() onTap}) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
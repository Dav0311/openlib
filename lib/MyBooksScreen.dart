import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:openlibrary/models/Book.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  late List<Book> books = [];
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    try {
      var course = 'information+technology';
      final prefs = await SharedPreferences.getInstance();
      final user = prefs.getString('user');
      if (user != null) {
        final userMap = jsonDecode(user);
        course = userMap['course'];
      }
      final url =
          'https://openlibrary.org/search.json?q=$course&fields=title,author_name,first_sentence,ratings_count,first_publish_year,number_of_pages_median,ebook_access,ebook_access&page=$currentPage&limit=10';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body)['docs'];

        List<Book> newBooks = [];

        responseData.forEach((book) {
          newBooks.add(Book.fromJson(book));
        });

        setState(() {
          books.addAll(newBooks);
          currentPage++;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      log("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            fetchBooks();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: books.length + 1,
          itemBuilder: (context, index) {
            if (index < books.length) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 2,
                  child: buildBookListTile(bookDetails: books[index]),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  buildBookListTile({required Book bookDetails}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bookDetails.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text("Author: ${bookDetails.authorName}"),
          const SizedBox(height: 10),
          Text("First Sentence: ${bookDetails.firstSentence}"),
          const SizedBox(height: 10),
          Text("Ratings Count: ${bookDetails.ratingsCount}"),
          const SizedBox(height: 10),
          Text("First Publish Year: ${bookDetails.firstPublishYear}"),
          const SizedBox(height: 10),
          Text("Number of Pages: ${bookDetails.numberOfPagesMedian}"),
          const SizedBox(height: 10),
          Text("Ebook Access: ${bookDetails.ebookAccess}"),
        ],
      ),
    );
  }
}

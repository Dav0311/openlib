import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:openlibrary/MyBooksScreen.dart';
import 'package:openlibrary/SettingsScreen.dart';

import 'package:openlibrary/courses/course_details.dart';
import 'package:openlibrary/models/Course.dart';
import 'package:openlibrary/models/CourseUnit.dart';
import 'package:openlibrary/models/Document.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  PDFViewerScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: Color.fromARGB(235, 3, 41, 67),
      ),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Course>> cpdDocuments;
  late List<Document> fetchedData = [];

  @override
  void initState() {
    super.initState();
    cpdDocuments = getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COURSES'),
        backgroundColor: Color.fromARGB(235, 3, 41, 67),
      ),
      body: FutureBuilder(
          future: cpdDocuments,
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
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 columns
                      ),
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        // final icon = departmentIcons[index];
                        return _buildDepartmentTile(data, context);
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  ),
                ],
              );
            }
          }),

      // Add your bottom navigation bar here
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(236, 4, 8, 83),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Library',
            backgroundColor: Color.fromARGB(236, 4, 8, 83),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color.fromARGB(236, 4, 8, 83),
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // Navigate to My Books screen
            // Navigator.of(context).pushNamed('/MyBooksScreen');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyBooksScreen()));
          } else if (index == 2) {
            // Navigate to Settings screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
          }
          // Handle other navigation here if needed
        },
      ),
    );
  }

  Widget _buildDepartmentTile(Course course, BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate to course details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetails(course: course),
          ),
        );
      },
      child: Card(
        color: Color.fromARGB(244, 7, 43, 63),
        margin: EdgeInsets.all(8.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(5.0),
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book,
                size: 40.0,
                color: Color.fromARGB(255, 13, 1, 1),
              ),
              SizedBox(height: 5.0),
              Text(
                course.name,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Course>> getDocuments() async {
    try {
      final url = Uri.parse('http://192.168.1.5:8000/api/documents');

      // Get the token from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);

      print("response: ${response.body}");

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body)['data'];

        List<Course> courses = [];

        // Iterate through each course in the response
        responseData.forEach((courseName, courseData) {
          List<CourseUnit> courseUnits = [];

          // Iterate through each course unit in the course data
          courseData.forEach((courseUnitName, documents) {
            List<Document> unitDocuments = [];

            // Iterate through each document in the course unit
            documents.forEach((document) {
              unitDocuments.add(Document.fromJson(document));
            });

            courseUnits.add(
                CourseUnit(name: courseUnitName, documents: unitDocuments));
          });

          courses.add(Course(name: courseName, course_units: courseUnits));
        });

        return courses;
      } else {
        throw Exception('Failed to load documents');
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}

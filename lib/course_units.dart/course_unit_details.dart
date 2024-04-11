import 'package:flutter/material.dart';
import 'package:openlibrary/documents/document_details.dart';
import 'package:openlibrary/models/CourseUnit.dart';

class CourseUnitDetails extends StatefulWidget {
  final CourseUnit courseUnit;

  const CourseUnitDetails({Key? key, required this.courseUnit}) : super(key: key);

  @override
  State<CourseUnitDetails> createState() => _CourseUnitDetailsState();
}

class _CourseUnitDetailsState extends State<CourseUnitDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseUnit.name),
        backgroundColor: Color.fromARGB(235, 3, 41, 67),
        elevation: 4, // Add elevation for a subtle shadow
      ),
      body: ListView.builder(
        itemCount: widget.courseUnit.documents.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2, // Add elevation for a card-like effect
              child: ListTile(
                title: Text(widget.courseUnit.documents[index].file_name),
                onTap: () {
                  // Navigate to the document details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DocumentDetail(
                        document: widget.courseUnit.documents[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

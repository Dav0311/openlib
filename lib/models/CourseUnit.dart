import 'package:openlibrary/models/Document.dart';

class CourseUnit{
  final String name;
  List<Document> documents = [];

  CourseUnit({
    required this.name,
    required this.documents,
  });

  factory CourseUnit.fromJson(Map<String, dynamic> json) {
    return CourseUnit(
      name: json['name'],
      documents: json['documents'],
    );
  }
}
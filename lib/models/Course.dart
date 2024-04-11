import 'package:openlibrary/models/CourseUnit.dart';

class Course {
  final String name;

  List<CourseUnit> course_units = [];

  Course({
    required this.name,
    required this.course_units,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      course_units: json['course_units'],
    );
  }
}

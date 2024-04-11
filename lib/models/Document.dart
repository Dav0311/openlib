class Document{
  final int id;
  final String file_name;
  final String file_path;
  final String course;
  final String course_unit;

  const Document({
    required this.id,
    required this.file_name,
    required this.file_path,
    required this.course,
    required this.course_unit
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      file_name: json['file_name'],
      file_path: json['file_path'],
      course: json['course'],
      course_unit: json['course_unit']
    );
  }
}
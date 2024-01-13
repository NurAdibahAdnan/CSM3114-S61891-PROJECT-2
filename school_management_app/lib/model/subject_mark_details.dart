class Marks {
  final String id;
  final String studentId;
  final String course;
  final double marks;

  Marks({
    required this.id,
    required this.studentId,
    required this.course,
    required this.marks,
  });

  // Factory method to create Marks instance from JSON
  factory Marks.fromJson(Map<String, dynamic> json) {
    return Marks(
      id: json['id'],
      studentId: json['studentId'],
      course: json['course'],
      marks: json['marks'].toDouble(),
    );
  }
}

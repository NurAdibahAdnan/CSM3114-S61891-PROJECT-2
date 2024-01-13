import 'package:school_management_app/model/lecturer.dart';


class DummyLecturer {
  static List<Lecturer> getLecturers() {
    return [
      Lecturer(
        id: '101',
        name: 'Dr. Adibah',
        address: 'Tanah Merah,Kelantan',
        coursesTaught: ['CSM3123', 'CSM3114'],
        email: 'ad@example.com',
        password: '4567',
        about: 'Dr Adibah is a lecturer at ftkki that mostly teaches Flutter Framework and Dart Programming',
        profilePictureUrl: 'assets/images/student1.png',
      ),
      // Add more lecturer instances as needed
    ];
  }
}

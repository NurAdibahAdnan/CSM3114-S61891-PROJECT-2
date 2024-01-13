import 'package:school_management_app/model/student.dart';

class DummyStudent {
  static List<Student> getStudents() {
    return [
      Student(
        id: 's61891',
        name: 'Adibah Adnan',
        age: 20,
        address: 'Tanah Merah,Kelantan',
        email: 'ad@gmail.com',
        password: '1234',
        about: 'Adibah is a student of CSM3123',
        profilePictureUrl: 'assets/images/student1.png',
      ),
      // Add more student instances as needed
    ];
  }
}
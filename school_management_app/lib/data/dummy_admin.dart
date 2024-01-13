import 'package:school_management_app/model/admin.dart';

class DummyAdmin {
  static List<Admin> getAdmins() {
    return [
      Admin(
        id: '111',
        name: 'Miss Malika',
        address: 'Kuala Terengganu,Terengganu',
        department: 'Discipline Department',
        email: 'malika@example.com',
        password: '4567',
        about: 'Miss Malika is a staff at ftkki that mostly handles the discipline records',
        profilePictureUrl: 'assets/images/student1.png',
      ),
      Admin(
        id: '112',
        name: 'Mr Akim',
        address: 'Kuala Terengganu,Terengganu',
        department: 'Eduction Department',
        email: 'akim@example.com',
        password: '4567',
        about: 'Mr Akim is a staff at ftkki that mostly handles the student results',
        profilePictureUrl: 'assets/images/student1.png',
      ),
      // Add more lecturer instances as needed
    ];
  }
}

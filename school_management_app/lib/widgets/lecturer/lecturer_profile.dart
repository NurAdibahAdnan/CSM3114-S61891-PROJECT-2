import 'package:flutter/material.dart';
import 'package:school_management_app/model/lecturer.dart';

class LecturerProfileScreen extends StatelessWidget {
  final Lecturer lecturer;

  LecturerProfileScreen({required this.lecturer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecturer Profile'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(lecturer.profilePictureUrl),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'About: ${lecturer.about}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lecturer ID: ${lecturer.id}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Name: ${lecturer.name}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Address: ${lecturer.address}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Courses Taught:',
                          style: TextStyle(fontSize: 18),
                        ),
                        ...lecturer.coursesTaught.map((course) {
                          return Text(
                            course,
                            style: TextStyle(fontSize: 18),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

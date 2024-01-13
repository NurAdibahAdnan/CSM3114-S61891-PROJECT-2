import 'package:flutter/material.dart';
import 'package:school_management_app/model/student.dart';

class StudentProfileScreen extends StatelessWidget {
  final Student student;

  StudentProfileScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile_background.png'), // Replace with your image path
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
                backgroundImage: AssetImage(student.profilePictureUrl), // Use profilePictureUrl
                    backgroundColor: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'About: ${student.about}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        'Student ID: ${student.id}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Name: ${student.name}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Age: ${student.age}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Address: ${student.address}',
                        style: TextStyle(fontSize: 18),
                      ),
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

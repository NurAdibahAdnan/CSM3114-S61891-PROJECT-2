import 'package:flutter/material.dart';
import 'package:school_management_app/model/admin.dart';

class AdminProfileScreen extends StatelessWidget {
  final Admin admin;

  AdminProfileScreen({required this.admin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile'),
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
                  backgroundImage: AssetImage(admin.profilePictureUrl),
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'About: ${admin.about}',
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
                          'ID: ${admin.id}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Name: ${admin.name}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Address: ${admin.address}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Department: ${admin.department}',
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

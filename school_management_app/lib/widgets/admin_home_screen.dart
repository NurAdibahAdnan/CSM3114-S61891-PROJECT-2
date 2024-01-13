import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:school_management_app/widgets/admin/admin_discipline_update.dart';
import 'package:school_management_app/widgets/admin/admin_profile.dart';
import 'package:school_management_app/widgets/admin/admin_student_mark.dart';
import 'package:school_management_app/widgets/login_screen.dart';
import 'package:school_management_app/widgets/logowidget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key, required this.loggedInUser}) : super(key: key);

  final dynamic loggedInUser;

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 60.0,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.purple),
                child: Text('School Management System'),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminProfileScreen(admin: widget.loggedInUser),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Student Result'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminStudentMark(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Discipline Status View'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminDisciplineList(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/beach_umt.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Carousel Slider
            SizedBox(height: 10.0),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                enlargeCenterPage: true,
              ),
              items: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/image1.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/image2.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/image3.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage('assets/images/image4.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35.0),
            // Welcome Text
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Welcome, ${widget.loggedInUser.name}!',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            // CircleIconButton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleIconButton(
                  icon: Icons.assignment,
                  tooltip: 'Student Result',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminStudentMark(),
                      ),
                    );
                  },
                ),
                CircleIconButton(
                  icon: Icons.account_circle,
                  tooltip: 'Profile',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AdminProfileScreen(admin: widget.loggedInUser),
                      ),
                    );
                  },
                ),
                CircleIconButton(
                  icon: Icons.warning,
                  tooltip: 'Student Discipline Status',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminDisciplineList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

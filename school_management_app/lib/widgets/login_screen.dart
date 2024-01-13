import 'package:school_management_app/data/dummy_admin.dart';
import 'package:school_management_app/data/dummy_lecturer.dart';
import 'package:school_management_app/data/dummy_student.dart';
import 'package:flutter/material.dart';
import 'package:school_management_app/model/admin.dart';
import 'package:school_management_app/model/lecturer.dart';
import 'package:school_management_app/model/student.dart';
import 'package:school_management_app/widgets/admin_home_screen.dart';
import 'package:school_management_app/widgets/lecturer_home_screen.dart';
import 'package:school_management_app/widgets/student_home_screen.dart';
import 'package:school_management_app/widgets/logowidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late String _userType;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userType = "student"; // Default to student
  }

  Future<void> signIn() async {
    // Get the entered email and password
    String enteredEmail = _emailController.text;
    String enteredPassword = _passwordController.text;

    try {
      dynamic loggedInUser = _userType == "lecturer"
          ? DummyLecturer.getLecturers().firstWhere(
              (lec) =>
                  lec.email == enteredEmail && lec.password == enteredPassword,
              orElse: () => throw StateError('No element'),
            )
          : _userType == "student"
              ? DummyStudent.getStudents().firstWhere(
                  (stu) =>
                      stu.email == enteredEmail &&
                      stu.password == enteredPassword,
                  orElse: () => throw StateError('No element'),
                )
              : _userType == "admin"
                  ? DummyAdmin.getAdmins().firstWhere(
                      (admin) =>
                          admin.email == enteredEmail &&
                          admin.password == enteredPassword,
                      orElse: () => throw StateError('No element'),
                    )
                  : null;

      if (loggedInUser != null) {
        // Successfully logged in
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (_userType == "lecturer") {
                return LecturerHomeScreen(loggedInUser: loggedInUser as Lecturer);
              } else if (_userType == "student") {
                return StudentHomeScreen(loggedInUser: loggedInUser as Student);
              } else if (_userType == "admin") {
                return AdminHomeScreen(loggedInUser: loggedInUser as Admin);
              } else {
                return Scaffold(); // Handle other user types
              }
            },
          ),
        );
      } else {
        // Show an AlertDialog for invalid credentials
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Credentials'),
              content: Text('Please check your email and password.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Handle the StateError (No element)
      // Show an AlertDialog for invalid credentials
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('Please check your email and password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_background.png"), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              logoWidget("assets/images/Logo_Rasmi_UMT.png"),
              Text("Welcome! Please Login."),
              SizedBox(height: 20),
              buildTextField("Email", Icons.email, _emailController, false),
              SizedBox(height: 20),
              buildTextField("Password", Icons.lock, _passwordController, true),
              SizedBox(height: 20),
              buildUserTypeSelection(),
              SizedBox(height: 10),
              buildLoginButton(),
            ],
          ),
        ),
      ),
    ),
  );
}
  Widget buildTextField(
      String label, IconData icon, TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildUserTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Select user type:"),
        Row(
          children: <Widget>[
            Radio(
              value: "lecturer",
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value.toString();
                });
              },
            ),
            Text("Lecturer"),
            Radio(
              value: "student",
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value.toString();
                });
              },
            ),
            Text("Student"),
            Radio(
              value: "admin",
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value.toString();
                });
              },
            ),
            Text("Admin"),
          ],
        ),
      ],
    );
  }

  Widget buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        String email = _emailController.text;
        String password = _passwordController.text;

        // Check if the email or password is empty
        if (email.isEmpty || password.isEmpty) {
          // Show an alert dialog indicating that the form is incomplete
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Incomplete Form'),
                content: Text('Please fill in both email and password.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          return; // Stop further execution if the form is incomplete
        }

        // Continue with successful login logic (calling signIn method)
        await signIn();
      },
      child: Text('Login'),
    );
  }
}

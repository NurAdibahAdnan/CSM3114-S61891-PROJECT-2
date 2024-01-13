
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarksInputScreen extends StatefulWidget {
  const MarksInputScreen({Key? key}) : super(key: key);

  @override
  _MarksInputScreenState createState() => _MarksInputScreenState();
}

class _MarksInputScreenState extends State<MarksInputScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredStudentId = '';
  var _enteredCourse = '';
  var _enteredMarks = 0;

  void _saveMarks() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
      });
      _formKey.currentState!.save();

      final url = Uri.https(
        'school-management-app-a8394-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/student-marks.json' 
      );

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json', 
          },
          body: json.encode(
            {
              'id': DateTime.now().toString(),
              'studentId': _enteredStudentId,
              'course': _enteredCourse,
              'marks': _enteredMarks,
            },
          ),
        );

        if (response.statusCode == 200) {
          // Show a Snackbar on successful form submission
          Text('Marks submitted successfully!');

          // Check the data and status code.
          print('Response Body: ${response.body}');
          print('Status Code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error: $error');
        // Handle error as needed
      }

      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Marks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Student ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a student ID.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredStudentId = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Course'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredCourse = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Marks'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter marks.';
                  }
                  final marks = int.tryParse(value);
                  if (marks == null || marks < 0 || marks > 100) {
                    return 'Please enter a valid marks between 0 and 100.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredMarks = int.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveMarks,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

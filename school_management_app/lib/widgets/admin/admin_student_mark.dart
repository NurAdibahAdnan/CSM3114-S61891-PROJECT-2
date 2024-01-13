import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management_app/model/subject_mark_details.dart';


class AdminStudentMark extends StatefulWidget {

  @override
  __AdminStudentMarkState createState() => __AdminStudentMarkState();
}

class __AdminStudentMarkState extends State<AdminStudentMark> {
  List<Marks> _marksList = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMarks();
  }

  void _loadMarks() async {
    final url = Uri.https(
        'school-management-app-a8394-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/student-marks.json' 
    );

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Error: Failed to fetch data. Please try again later.';
          _isLoading = false; // Added to handle loading state on error
        });
        return;
      }

      print('#Debug student_marks.dart');
      print(response.body);

      // Check if no records in Firebase, terminate the program here
      if (response.body.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      print('#Debug student_marks.dart');
      print(listData);

      final List<Marks> _loadedMarks = [];

      listData.forEach((key, value) {
        final mark = Marks.fromJson(value);
        _loadedMarks.add(mark);
      });

      setState(() {
        _marksList = _loadedMarks;
        _isLoading = false;
      });
    } catch (error) {
      print('Error: $error');
      setState(() {
        _error = 'Error occurred. Please try again later.';
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteMark(String studentId) async {
    final url = Uri.https(
      'school-management-app-a8394-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/student-marks/$studentId.json',
    );

    try {
      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Error: Failed to delete data. Please try again later.';
        });
        return;
      }

      setState(() {
        _marksList.removeWhere((mark) => mark.studentId == studentId);
      });
    } catch (error) {
      print('Error: $error');
      setState(() {
        _error = 'Error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No marks available yet.'));

    // Add for progress status
    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_marksList.isNotEmpty) {
      content = ListView.builder(
        itemCount: _marksList.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text('StudentId: ${_marksList[index].studentId}', style: TextStyle(fontSize: 16)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Course: ${_marksList[index].course}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Marks: ${_marksList[index].marks}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Show a confirmation dialog when deleting an item
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Delete'),
                    content: Text('Are you sure you want to delete this mark?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Delete the mark if confirmed
                          _deleteMark(_marksList[index].studentId);
                          Navigator.of(context).pop();
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Marks'),
      ),
      body: content,
    );
  }
}
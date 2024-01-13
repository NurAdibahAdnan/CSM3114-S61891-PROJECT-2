import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:school_management_app/data/discipline_categories.dart';
import 'package:school_management_app/model/discipline_category.dart';
import 'package:school_management_app/model/discipline_report.dart';
import 'package:http/http.dart' as http;

class DisciplineNewForm extends StatefulWidget {
  const DisciplineNewForm({Key? key});

  @override
  State<DisciplineNewForm> createState() => _DisciplineNewFormState();
}

class _DisciplineNewFormState extends State<DisciplineNewForm> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredReasons = "";
  var _selectedDisciplineStatus = disciplineStatusData[DisciplineStatus.Good]!;
  var _isSending = false;

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();

      final url = Uri.https(
        'school-management-app-a8394-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/discipline-form.json',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Set content type to JSON
        },
        body: json.encode(
          {
            'name': _enteredName,
            'reasons': _enteredReasons,
            'status': _selectedDisciplineStatus.toJson(), // Convert to JSON
          },
        ),
      );

      if (response.statusCode == 200) {
        // Show a Snackbar on successful form submission
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Form submitted successfully!'),
            duration: Duration(seconds: 5),
          ),
        );

        // Check the data and status code.
        print('Response Body: ${response.body}');
        print('Status Code: ${response.statusCode}');

        final Map<String, dynamic> resData = json.decode(response.body);

        // Check if the context for the widget is NULL
        if (!context.mounted) {
          return;
        }

        // Adding the current record into DisciplineReport
        Navigator.of(context).pop(
          DisciplineReport(
            id: resData['name'], // Assuming 'name' is a String
            name: _enteredName,
            reasons: [_enteredReasons], // Assuming reasons is a List<String>
            disciplineStatus: _selectedDisciplineStatus,
          ),
        );
      }
    }
    setState(() {
      _isSending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new discipline report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Please fill in the student name'
                ),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Reasons',
                        hintText: 'Please fill in the reasons'
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      initialValue: _enteredReasons.toString(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Must have values.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredReasons = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedDisciplineStatus,
                      items: [
                        for (final status in disciplineStatusData.entries)
                          DropdownMenuItem(
                            value: status.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: status.value.color,
                                ),
                                const SizedBox(width: 6),
                                Text(status.value.label),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedDisciplineStatus = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveForm,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add New Report'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

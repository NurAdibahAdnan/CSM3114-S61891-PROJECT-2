import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management_app/data/discipline_categories.dart';
import 'package:school_management_app/model/discipline_report.dart';

class AdminDisciplineList extends StatefulWidget {
  const AdminDisciplineList({super.key});

  @override
  State<AdminDisciplineList> createState() => _AdminDisciplineListState();
}

class _AdminDisciplineListState extends State<AdminDisciplineList> {
  List<DisciplineReport> _disciplineItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
    print('Passing');
  }

  void _loadItems() async {
    final url = Uri.https(
      'school-management-app-a8394-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/discipline-form.json',
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

      print('#Debug discipline_list.dart');
      print(response.body);

      // Check if no records in firebase, terminate the program here
      if (response.body.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      print('#Debug discipline_list.dart');
      print(listData);

      for (final entry in disciplineStatusData.entries) {
        print('Category: ${entry.value.status}');
      }
      final List<DisciplineReport> _loadedItems = [];
      for (final entry in listData.entries) {
        print('Status: ${entry.value['status']}');
        try {
          final category = disciplineStatusData.entries
              .firstWhere(
                (catItem) => catItem.value.status == entry.value['status'],
                orElse: () => disciplineStatusData.entries.first,
              )
              .value;
          print('Category: $category');

          // Update the reasons field to be a List<String>
          dynamic reasonsData = entry.value['reasons'];
          final reasons = reasonsData is List<dynamic>
              ? reasonsData.map((reason) => reason.toString()).toList()
              : [reasonsData.toString()];

          _loadedItems.add(
            DisciplineReport(
              id: entry.key,
              name: entry.value['name'],
              reasons: reasons,
              disciplineStatus: category,
            ),
          );
        } catch (e) {
          print('Error processing entry: $e');
        }
      }

      setState(() {
        _disciplineItems = _loadedItems;
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

  Future<void> _deleteItem(String id) async {
    final url = Uri.https(
      'school-management-app-a8394-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/discipline-form/$id.json',
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
        _disciplineItems.removeWhere((item) => item.id == id);
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
    Widget content = const Center(child: Text('No items added yet.'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_disciplineItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _disciplineItems.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(_disciplineItems[index].name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reasons:'),
              for (var reason in _disciplineItems[index].reasons)
                Text('- $reason'),
            ],
          ),
          leading: Container(
            width: 0,
            height: 0,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Show a confirmation dialog when deleting an item
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Delete'),
                        content:
                            Text('Are you sure you want to delete this item?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Delete the item if confirmed
                              _deleteItem(_disciplineItems[index].id);
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
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discipline Reports'),
      ),
      body: content,
    );
  }
}
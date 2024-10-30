import 'dart:convert';
import 'package:dynamic_form_generator/components/json_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormBuilderDemo extends StatefulWidget {
  const FormBuilderDemo({super.key});

  @override
  _FormBuilderDemoState createState() => _FormBuilderDemoState();
}

class _FormBuilderDemoState extends State<FormBuilderDemo> {
  List<Map<String, dynamic>>? formFields;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchFormFields();
  }

  Future<void> _fetchFormFields() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/formFields'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          formFields =
              data.map((field) => field as Map<String, dynamic>).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load form fields. Please try again.';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'An error occurred: $error';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Form '),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        // reload button
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
                errorMessage = null;
              });
              _fetchFormFields();
            },
          ),
        ],
      ),
      drawer: const Drawer(),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.work,
          ),
          label: 'Job Application',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance,
            ),
            label: 'Mutuelle'),
      ]),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      JsonFormBuilder(
                        jsonFields: formFields!,
                        onSubmit: (formData) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Form Submission'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: formData.entries.map((entry) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Text(
                                        '${entry.key}: ${entry.value}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
    );
  }
}

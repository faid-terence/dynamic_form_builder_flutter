import 'package:dynamic_form_generator/components/json_form_builder.dart';
import 'package:dynamic_form_generator/components/my_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MutuelleApplication extends StatefulWidget {
  const MutuelleApplication({super.key});

  @override
  State<MutuelleApplication> createState() => _MutuelleApplicationState();
}

class _MutuelleApplicationState extends State<MutuelleApplication> {
  List<Map<String, dynamic>>? formFields;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchFormFields();
  }

  Future _fetchFormFields() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/mutuelleApplication'));
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

  // validate the national ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutuelle de santé'),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Provide the following details',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      JsonFormBuilder(
                        jsonFields: formFields!,
                        onSubmit: (data) {
                          print(data);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Pay with: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "0780 000 000",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight
                                          .bold, // Makes the number bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/paymentMethods");
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.purple,
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.purple,
                                ),
                              ),
                              child: const Text("Edit"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyCustomButton(text: "Pay", onPressed: () {}),
                    ],
                  ),
      ),
    );
  }
}

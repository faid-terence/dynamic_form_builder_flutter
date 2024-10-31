import 'package:dynamic_form_generator/components/json_form_builder.dart';

import 'package:dynamic_form_generator/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
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
      final response =
          await http.get(Uri.parse('http://localhost:3000/paymentMethods'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        setState(() {
          formFields =
              data.map((field) => field as Map<String, dynamic>).toList();
          isLoading = false;
          print(formFields);
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

  void saveNumber() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '"Number" saved successfully',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, "/UserPayments");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!),
                )
              : Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      JsonFormBuilder(
                        jsonFields: formFields!,
                        onSubmit: (data) {
                          print(data);
                        },
                      ),
                      const Text(
                        "This is the number that will be used to pay. It can be MTN or Airtel Mobile Money",
                      ),
                      const SizedBox(height: 40),
                      PrimaryButton(
                        text: "Save Number",
                        onPressed: saveNumber,
                      ),
                    ],
                  ),
                ),
    );
  }
}

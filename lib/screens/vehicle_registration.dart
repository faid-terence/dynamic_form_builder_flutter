import 'package:dynamic_form_generator/components/json_form_builder.dart';
import 'package:dynamic_form_generator/components/primary_button.dart';
import 'package:dynamic_form_generator/screens/added_vehicles.dart';
import 'package:dynamic_form_generator/services/vehicle_registration.dart';
import 'package:flutter/material.dart';

class VehicleRegistration extends StatefulWidget {
  const VehicleRegistration({super.key});

  @override
  State<VehicleRegistration> createState() => _VehicleRegistrationState();
}

class _VehicleRegistrationState extends State<VehicleRegistration> {
  final VehicleRegistrationService _vehicleRegistrationService =
      VehicleRegistrationService();
  List<Map<String, dynamic>>? formFields;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFormFields();
  }

  Future<void> _loadFormFields() async {
    try {
      final fields = await _vehicleRegistrationService.fetchFormFields();
      setState(() {
        formFields = fields;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set up your account'),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "To have a better personalized experience with your app, please answer the following \nprompts.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            const Text(
              "1. Vehicle ownership",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 120,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 120,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Please provide the vehicle's details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(child: Text(errorMessage!))
                    : JsonFormBuilder(
                        jsonFields: formFields!,
                        onSubmit: (value) => print(value),
                      ),
            const SizedBox(height: 30),
            PrimaryButton(
                text: "Add vehicle",
                onPressed: () {
                  // navigate to Added vehicles screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddedVehicles()));
                }),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Skip this step",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

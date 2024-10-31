import 'package:dynamic_form_generator/components/json_form_builder.dart';
import 'package:dynamic_form_generator/components/primary_button.dart';
import 'package:dynamic_form_generator/components/transparent_button.dart';
import 'package:dynamic_form_generator/screens/setup_payment_methods.dart';
import 'package:dynamic_form_generator/services/vehicle_registration.dart';
import 'package:flutter/material.dart';

class AddMoreVehicles extends StatefulWidget {
  const AddMoreVehicles({super.key});

  @override
  State<AddMoreVehicles> createState() => _AddMoreVehiclesState();
}

class _AddMoreVehiclesState extends State<AddMoreVehicles> {
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
                    color: Colors.grey.shade300,
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
            const Text(
              "1. RAD 514 X",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
            const SizedBox(height: 60),
            TransparentButton(
              onPressed: () {
                // Define your button action
              },
              text: 'Add Vehicle',
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              borderColor: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
                text: "Continue",
                onPressed: () {
                  // navigate to Setup payment methods screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SetupPaymentMethods()));
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

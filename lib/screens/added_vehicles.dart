import 'package:dynamic_form_generator/components/primary_button.dart';
import 'package:dynamic_form_generator/screens/add_more_vehicles.dart';
import 'package:dynamic_form_generator/screens/setup_payment_methods.dart';
import 'package:flutter/material.dart';

class AddedVehicles extends StatelessWidget {
  const AddedVehicles({super.key});

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
            GestureDetector(
              onTap: () {
                // navigate to Add more vehicles screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddMoreVehicles()));
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.purple,
                  ),
                  Text(
                    "Add another vehicle",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
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

import 'package:flutter/material.dart';

class VehicleSetupForm extends StatefulWidget {
  @override
  _VehicleSetupFormState createState() => _VehicleSetupFormState();
}

class _VehicleSetupFormState extends State<VehicleSetupForm> {
  final _pageController = PageController();
  int _currentStep = 0;

  String? _vehicleOwnership;
  String _plateNumber = '';
  String _tin = '';
  List<Map<String, String>> _vehicles = [];

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _prevStep() {
    setState(() {
      _currentStep--;
    });
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _addVehicle() {
    setState(() {
      _vehicles.add({
        'Plate Number': _plateNumber,
        'TIN': _tin,
      });
      _plateNumber = '';
      _tin = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set up your account"),
        leading: _currentStep > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: _prevStep,
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildStepOne(),
                  _buildStepTwo(),
                  _buildStepThree(),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                // Implement skip logic if needed
              },
              child: Text("Skip this step"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "To have a better personalized experience with your app, please answer the following prompts.",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 24),
        Text(
          "1. Vehicle Ownership",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
            "Do you have a vehicle (car or bike) you'd like to receive notifications for?"),
        SizedBox(height: 16),
        ListTile(
          title: Text("Yes, I do"),
          leading: Radio<String>(
            value: "Yes",
            groupValue: _vehicleOwnership,
            onChanged: (value) {
              setState(() {
                _vehicleOwnership = value;
              });
              _nextStep();
            },
          ),
        ),
        ListTile(
          title: Text("No, I don't"),
          leading: Radio<String>(
            value: "No",
            groupValue: _vehicleOwnership,
            onChanged: (value) {
              setState(() {
                _vehicleOwnership = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "To have a better personalized experience with your app, please answer the following prompts.",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 24),
        Text(
          "2. Vehicle Registration",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text("Please provide the vehicle's details"),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(labelText: "Plate Number"),
          onChanged: (value) => _plateNumber = value,
        ),
        TextField(
          decoration: InputDecoration(labelText: "TIN"),
          onChanged: (value) => _tin = value,
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed:
              _plateNumber.isNotEmpty && _tin.isNotEmpty ? _addVehicle : null,
          child: Text("Add Vehicle"),
        ),
      ],
    );
  }

  Widget _buildStepThree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "To have a better personalized experience with your app, please answer the following prompts.",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 24),
        Text(
          "2. Vehicle Registration",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text("Please provide the vehicle's details"),
        SizedBox(height: 16),
        Column(
          children: _vehicles.map((vehicle) {
            return ListTile(
              title: Text(vehicle['Plate Number']!),
              subtitle: Text("TIN: ${vehicle['TIN']}"),
            );
          }).toList(),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _currentStep = 1;
            });
            _pageController.jumpToPage(1);
          },
          child: Text("+ Add another vehicle"),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _vehicles.isNotEmpty ? _nextStep : null,
          child: Text("Continue"),
        ),
      ],
    );
  }
}

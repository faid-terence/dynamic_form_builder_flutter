import 'package:dynamic_form_generator/models/service.dart';
import 'package:flutter/material.dart';

class ServicesProvider extends ChangeNotifier {
  static List<Service> services = [
    Service(
      title: "Traffic Fines",
      imagePath: "assets/images/Icon.png",
      color: Colors.blue,
    ),
    Service(
      title: "Mutuelle de santé",
      imagePath: "assets/images/health.png",
      color: const Color.fromARGB(255, 85, 38, 93),
    ),
  ];

  List<Service> getServices() {
    return services;
  }

  // go to service screen
  int? currentServiceIndex;

  void setCurrentServiceIndex(int index) {
    currentServiceIndex = index;
    notifyListeners();
  }
}

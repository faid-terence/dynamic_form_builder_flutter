import 'package:dynamic_form_generator/models/updates.dart';
import 'package:flutter/material.dart';

class UpdatesProvider extends ChangeNotifier {
  static List<Updates> updates = [
    Updates(
      title: "Traffic Fines",
      description: "You have received a fine of 25,0...",
      imagePath: "assets/images/Icon.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      time: "15:00",
      notificationCount: 1,
    ),
    Updates(
      title: "Mutuelle de santé",
      description: "Hello, the fiscal year for communi...",
      imagePath: "assets/images/health.png",
      color: const Color.fromARGB(255, 85, 38, 93),
      time: "20:00",
      notificationCount: 1,
    ),
    Updates(
      title: "Birth Certificate",
      description: "Your birth certificate has been ap...",
      imagePath: "assets/images/birthcert.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      time: "12:00",
      notificationCount: 1,
    ),
    Updates(
      title: "Definitive Driving Test",
      description: "Your provisional driving test is on ...",
      imagePath: "assets/images/drive.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      time: "14:00",
      notificationCount: 1,
    ),
  ];

  List<Updates> getUpdates() {
    return updates;
  }

  // go to service screen
  int? currentUpdateIndex;

  void setCurrentUpdateIndex(int index) {
    currentUpdateIndex = index;
    notifyListeners();
  }
}

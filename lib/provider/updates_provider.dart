import 'dart:ui';
import 'package:dynamic_form_generator/models/updates.dart';
import 'package:flutter/foundation.dart';

class UpdatesProvider extends ChangeNotifier {
  static List<Updates> updates = [
    Updates(
      title: "Traffic Fines",
      description:
          "You have received a traffic fine of 25,000 RWF\n\nOffense: Over speeding\nSpeed: 68 KMH\nWhere: Nyarutarama, Green Hills\nPay Before: 25/02/2024 08:00PM",
      imagePath: "assets/images/Icon.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      time: "15:00",
      notificationCount: 1,
      hasToPay: true,
    ),
    Updates(
      title: "Mutuelle de santé",
      description:
          "Hello, the fiscal year for community-based health insurance is now open. Secure Your Health—Pay on Time 🩺",
      imagePath: "assets/images/health.png",
      color: const Color.fromARGB(255, 85, 38, 93),
      time: "20:00",
      notificationCount: 1,
      hasToPay: true,
      paymentLink: "/mutuelle",
    ),
    Updates(
      title: "Birth Certificate",
      description:
          "🎉 Your request for the birth certificate has been received, we will send it to you by tomorrow.",
      imagePath: "assets/images/birthcert.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      time: "12:00",
      notificationCount: 1,
    ),
    Updates(
      title: "Definitive Driving Test",
      description:
          "Your definitive driving test is on Tuesday, May 04.\n \nHere is your registration code:\n123456789034567",
      imagePath: "assets/images/drive.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      time: "14:00",
      notificationCount: 1,
    ),
    Updates(
      title: "Traffic Fines",
      description:
          "Your traffic fine is due soon.\nPay by 25/02/2024 08:00PM to avoid late fees.",
      imagePath: "assets/images/Icon.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      time: "15:00",
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

  void setNotificationCount(int index, int count) {
    updates[index].notificationCount = count;
    notifyListeners();
  }
}

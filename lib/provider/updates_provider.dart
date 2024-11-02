import 'dart:ui';
import 'package:dynamic_form_generator/models/updates.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class UpdatesProvider extends ChangeNotifier {
  static final List<Updates> _updates = [
    Updates(
      title: "Traffic Fines",
      description:
          "You have received a traffic fine of 25,000 RWF\n\nOffense: Over speeding\nSpeed: 68 KMH\nWhere: Nyarutarama, Green Hills\nPay Before: ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse("2024-02-25 20:00:00"))}",
      imagePath: "assets/images/Icon.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      date: DateTime.parse("2024-10-22"),
      notificationCount: 1,
      hasToPay: true,
    ),
    Updates(
      title: "Mutuelle de santé",
      description:
          "Hello, the fiscal year for community-based health insurance is now open. Secure Your Health—Pay on Time 🩺",
      imagePath: "assets/images/health.png",
      color: const Color.fromARGB(255, 85, 38, 93),
      date: DateTime.parse("2024-10-21"),
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
      date: DateTime.parse("2024-10-23"),
      notificationCount: 1,
    ),
    Updates(
      title: "Birth Certificate",
      description:
          "🎉 Your request for the birth certificate has been approved, we will send it to you by tomorrow.",
      imagePath: "assets/images/birthcert.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      date: DateTime.parse("2024-10-25"),
      notificationCount: 1,
    ),
    Updates(
      title: "Definitive Driving Test",
      description:
          "Your definitive driving test is on ${DateFormat('EEEE, MMMM dd').format(DateTime.parse("2024-05-04"))}.\n\nHere is your registration code:\n123456789034567",
      imagePath: "assets/images/drive.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      date: DateTime.parse("2024-10-26"),
      notificationCount: 1,
    ),
    Updates(
      title: "Traffic Fines",
      description:
          "Your traffic fine is due soon.\nPay by ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse("2024-02-25 20:00:00"))} to avoid late fees.",
      imagePath: "assets/images/Icon.png",
      color: const Color.fromARGB(255, 255, 174, 0),
      date: DateTime.parse("2024-10-27"),
      notificationCount: 1,
    ),
  ];

  List<Updates> getUpdates() {
    return _updates;
  }

  // Add helper method for date formatting
  String getFormattedDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${DateFormat('hh:mm a').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat('hh:mm a').format(date)}';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE, hh:mm a').format(date);
    } else {
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    }
  }

  List<Updates> getUpdatesByTitle(String title) {
    return _updates.where((update) => update.title == title).toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // Sort by date, newest first
  }

  // Method to add a new update
  void addUpdate(Updates update) {
    _updates.add(update);
    notifyListeners();
  }

  // Method to mark all notifications of a title as read
  void setNotificationCountByTitle(String title, int count) {
    for (var update in _updates) {
      if (update.title == title) {
        update.notificationCount = count;
      }
    }
    notifyListeners();
  }

  // go to service screen
  int? currentUpdateIndex;

  void setCurrentUpdateIndex(int index) {
    currentUpdateIndex = index;
    notifyListeners();
  }

  void setNotificationCount(int index, int count) {
    _updates[index].notificationCount = count;
    notifyListeners();
  }

  int getTotalNotificationCount() {
    return _updates.fold(0, (sum, update) => sum + update.notificationCount);
  }

  // Optional: Add method to get grouped updates with formatted dates
  Map<String, List<Updates>> getGroupedUpdates() {
    final grouped = <String, List<Updates>>{};
    for (var update in _updates) {
      final formattedDate = getFormattedDate(update.date);
      grouped.putIfAbsent(formattedDate, () => []).add(update);
    }
    return grouped;
  }
}

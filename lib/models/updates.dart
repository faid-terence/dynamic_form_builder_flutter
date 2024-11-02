import 'package:flutter/material.dart';

class Updates {
  final String title;
  final String description;
  final String imagePath;
  final Color color;
  final DateTime date;
  int notificationCount;
  final bool hasToPay;
  final String? paymentLink;

  Updates({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
    required this.date,
    this.notificationCount = 0,
    this.hasToPay = false,
    this.paymentLink,
  });
}

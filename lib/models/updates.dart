import 'package:flutter/material.dart';

class Updates {
  final String title;
  final String imagePath;
  final String description;
  final Color color;
  final String time;
  final int notificationCount; // New property

  Updates({
    required this.title,
    required this.imagePath,
    required this.description,
    required this.color,
    required this.time,
    this.notificationCount = 0, // Default value for notification count
  });
}

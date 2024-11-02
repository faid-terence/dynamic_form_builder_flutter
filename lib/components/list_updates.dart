import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListUpdates extends StatelessWidget {
  final String title;
  final String description;
  final Color iconBackgroundColor;
  final String imagePath;
  final DateTime date;
  final int notificationCount;
  final VoidCallback onTap;

  const ListUpdates({
    super.key,
    required this.title,
    required this.description,
    required this.iconBackgroundColor,
    required this.imagePath,
    required this.date,
    this.notificationCount = 0,
    required this.onTap,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return DateFormat('HH:mm').format(date);
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE').format(date);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon with background color
                Container(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Image(
                      image: AssetImage(imagePath),
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Title, description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                // Time and notification badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatDate(date),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    if (notificationCount > 0) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          notificationCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 62, top: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

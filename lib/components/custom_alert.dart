import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String description;
  final Color iconBackgroundColor;
  final IconData icon;
  final String primaryButtonText;
  final String secondaryButtonText;
  final Color primaryButtonColor;
  final VoidCallback? onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;

  const CustomAlert({
    super.key,
    required this.title,
    required this.description,
    required this.iconBackgroundColor,
    required this.icon,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.primaryButtonColor,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 420,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(height: 40),

            // Title Text
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.2,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),

            // Description Text
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
                height: 1.3,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
            const Spacer(),

            // Buttons
            Row(
              children: [
                // Secondary Button
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onSecondaryButtonPressed?.call();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      secondaryButtonText,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Primary Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onPrimaryButtonPressed?.call();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryButtonColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      primaryButtonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

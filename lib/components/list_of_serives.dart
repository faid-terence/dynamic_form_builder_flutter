import 'package:flutter/material.dart';

class ListOfSerives extends StatelessWidget {
  final String title;
  final Color color;
  final String imagePath;
  final VoidCallback onTap;

  const ListOfSerives({
    super.key,
    required this.title,
    required this.color,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 25, left: 25, right: 0),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage(imagePath),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(title, style: const TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

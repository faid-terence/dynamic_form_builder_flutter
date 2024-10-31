import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const TransparentButton({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor ?? Colors.grey.shade400,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

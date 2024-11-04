import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:dynamic_form_generator/components/primary_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreenComponent extends StatelessWidget {
  final String imagePath;
  final String chatBubbleMessage;
  final String title;
  final String subtitle;
  final String buttonText;
  final String skipButtonText;
  final VoidCallback onButtonPressed;
  final VoidCallback onSkipPressed;
  final bool isActive; // For the dot indicator

  const OnboardingScreenComponent({
    super.key,
    required this.imagePath,
    required this.chatBubbleMessage,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.skipButtonText,
    required this.onButtonPressed,
    required this.onSkipPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(imagePath),
              Positioned(
                right: 10,
                top: 320,
                child: SizedBox(
                  width: 291,
                  height: 64,
                  child: BubbleSpecialThree(
                    text: chatBubbleMessage,
                    color: const Color(0xFFF2F2F7),
                    isSender: false,
                    textStyle: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.25,
                color: Color(0xFF475467),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 5,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF8413F5)
                      : const Color(0xFFE4E7EB),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 32,
                height: 5,
                decoration: BoxDecoration(
                  color: !isActive
                      ? const Color(0xFF8413F5)
                      : const Color(0xFFE4E7EB),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: PrimaryButton(
              text: buttonText,
              onPressed: onButtonPressed,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: TextButton(
              onPressed: onSkipPressed,
              child: Text(
                skipButtonText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1D1D1D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

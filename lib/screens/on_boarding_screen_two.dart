import 'package:dynamic_form_generator/components/onboarding_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreenTwo extends StatelessWidget {
  const OnBoardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenComponent(
      imagePath: "assets/images/onboard2.png",
      chatBubbleMessage:
          "🚔 Your traffic fine of 25,000 RWF has been successfully paid.",
      title: "Stay on Top of Your Payments",
      subtitle:
          "Handle all your payments like traffic fines in one place. Simple, fast, and secure.",
      buttonText: "Get Started",
      skipButtonText: "Back",
      onButtonPressed: () {},
      onSkipPressed: () {
        Navigator.pushNamed(context, "/onboarding1");
      },
      isActive: false,
    );
  }
}

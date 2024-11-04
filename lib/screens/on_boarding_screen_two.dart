import 'package:dynamic_form_generator/components/onboarding_screen.dart';
import 'package:dynamic_form_generator/screens/on_boarding_screen_one.dart';
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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnBoardingScreenOne(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      isActive: false,
    );
  }
}

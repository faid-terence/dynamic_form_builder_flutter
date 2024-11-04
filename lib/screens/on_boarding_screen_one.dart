import 'package:dynamic_form_generator/screens/on_boarding_screen_two.dart';
import 'package:dynamic_form_generator/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreenOne extends StatelessWidget {
  const OnBoardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      imagePath: "assets/images/onboard1.png",
      chatBubbleMessage: "🎉 Your birth certificate is available",
      title: "Access Your Essential Certificates Easily",
      subtitle:
          "Get your birth, marriage, and other certificates from the comfort of your home. Just quick applications with a few taps.",
      buttonText: "Next",
      skipButtonText: "Skip",
      onButtonPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnBoardingScreenTwo(),
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
      onSkipPressed: () {},
      isActive: true,
    );
  }
}

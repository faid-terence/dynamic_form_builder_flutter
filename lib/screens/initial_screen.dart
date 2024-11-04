import 'package:dynamic_form_generator/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_form_generator/components/language_select.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  String currentLanguage = 'English';

  void handleLanguageSelection(String language) {
    setState(() {
      currentLanguage = language;
      print('Language updated in InitialScreen: $language');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          OnboardingScreen(
            imagePath: "assets/images/onboard1.png",
            chatBubbleMessage: "🎉 Your birth certificate is available",
            title: "Access Your Essential Certificates Easily",
            subtitle:
                "Get your birth, marriage, and other certificates from the comfort of your home. Just quick applications with a few taps.",
            buttonText: "Next",
            skipButtonText: "Skip",
            onButtonPressed: () {},
            onSkipPressed: () {},
            isActive: true,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: LanguageSelect(
                  onLanguageSelected: handleLanguageSelection,
                  routeToNavigate: "/onboarding1",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

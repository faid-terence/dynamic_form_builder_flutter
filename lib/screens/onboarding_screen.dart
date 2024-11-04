import 'package:dynamic_form_generator/components/primary_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/onboard1.png"),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              "Access Your Essential Certificates Easily",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              textAlign: TextAlign.center,
              "Get your birth, marriage, and other certificates from the comfort of your home. Just quick applications with a few taps.",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                  color: Color(0xFF475467)),
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
                  color: const Color(0xFF8413F5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 32,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE4E7EB),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: PrimaryButton(text: "Next", onPressed: () {}),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: TextButton(
                onPressed: () {},
                child: const Text("Skip",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D1D1D)))),
          ),
        ],
        // image
        // title
        // subtitle
        // button
      ),
    );
  }
}

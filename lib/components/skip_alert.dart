import 'package:dynamic_form_generator/components/custom_alert.dart';
import 'package:flutter/material.dart';

class SkipAlert extends StatelessWidget {
  final Function()? onSkip;
  final Function()? onCancel;

  const SkipAlert({
    super.key,
    this.onSkip,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      title: "Skip adding car details",
      description:
          "If you skip this step, you won’t receive notifications about traffic fines.  You can always add this to your profile later.",
      iconBackgroundColor: const Color(0xFFF77402),
      icon: Icons.warning,
      primaryButtonText: "Go back",
      secondaryButtonText: "Skip",
      primaryButtonColor: const Color(0xFF8413F5),
      onPrimaryButtonPressed: onCancel,
      onSecondaryButtonPressed: onSkip,
    );
  }
}

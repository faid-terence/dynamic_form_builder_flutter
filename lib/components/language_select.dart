import 'package:dynamic_form_generator/components/primary_button.dart';
import 'package:flutter/material.dart';

class LanguageSelect extends StatefulWidget {
  final Function(String) onLanguageSelected;

  /// route to navigate to after language is selected
  final String routeToNavigate;

  const LanguageSelect({
    super.key,
    required this.onLanguageSelected,
    required this.routeToNavigate,
  });

  @override
  State<LanguageSelect> createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  String selectedLanguage = 'English'; // Default selection

  Widget _buildLanguageOption(String language) {
    bool isSelected = selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
          print('Selected Language: $language'); // Print on selection
          widget.onLanguageSelected(language); // Callback to parent
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.grey.shade300,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          language,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 396,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Choose Language',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildLanguageOption('English'),
          const SizedBox(height: 8),
          _buildLanguageOption('Français'),
          const SizedBox(height: 8),
          _buildLanguageOption('Kinyarwanda'),
          const SizedBox(height: 16),
          PrimaryButton(
            text: "Continue",
            onPressed: () {
              Navigator.pushNamed(context, widget.routeToNavigate);
            },
          ),
        ],
      ),
    );
  }
}

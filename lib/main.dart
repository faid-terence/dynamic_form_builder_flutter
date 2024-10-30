import 'package:dynamic_form_generator/screens/form_builder_demo.dart';
import 'package:dynamic_form_generator/screens/mutuelle_application.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Builder Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      home: const MutuelleApplication(),
      routes: {
        "/ ": (context) => const FormBuilderDemo(),
        "/mutuelle": (context) => const MutuelleApplication(),
      },
    );
  }
}

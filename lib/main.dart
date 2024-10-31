import 'package:dynamic_form_generator/screens/form_builder_demo.dart';
import 'package:dynamic_form_generator/screens/mutuelle_application.dart';
import 'package:dynamic_form_generator/screens/payment_methods.dart';
import 'package:dynamic_form_generator/screens/user_payments.dart';
import 'package:dynamic_form_generator/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_form_generator/provider/form_state_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FormStateProvider(),
      child: const MyApp(),
    ),
  );
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
      home: const WelcomeScreen(),
      routes: {
        "/ ": (context) => const FormBuilderDemo(),
        "/mutuelle": (context) => const MutuelleApplication(),
        "/paymentMethods": (context) => const PaymentMethods(),
        "/UserPayments": (context) => const UserPayments(),
      },
    );
  }
}

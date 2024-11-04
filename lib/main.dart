import 'package:dynamic_form_generator/provider/certificates_provider.dart';
import 'package:dynamic_form_generator/provider/updates_provider.dart';
import 'package:dynamic_form_generator/screens/certificates_screen.dart';
import 'package:dynamic_form_generator/screens/form_builder_demo.dart';
import 'package:dynamic_form_generator/screens/initial_screen.dart';
import 'package:dynamic_form_generator/screens/make_payments.dart';
import 'package:dynamic_form_generator/screens/mutuelle_application.dart';
import 'package:dynamic_form_generator/screens/on_boarding_screen_one.dart';
import 'package:dynamic_form_generator/screens/on_boarding_screen_two.dart';
import 'package:dynamic_form_generator/screens/payment_methods.dart';
import 'package:dynamic_form_generator/screens/user_payments.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_form_generator/provider/form_state_provider.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_form_generator/provider/services_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormStateProvider()),
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
        ChangeNotifierProvider(create: (_) => UpdatesProvider()),
        ChangeNotifierProvider(create: (_) => CertificatesProvider()),
      ],
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
      home: const InitialScreen(),
      routes: {
        "/ ": (context) => const FormBuilderDemo(),
        "/mutuelle": (context) => const MutuelleApplication(),
        "/paymentMethods": (context) => const PaymentMethods(),
        "/UserPayments": (context) => const UserPayments(),
        "/makePayments": (context) => const MakePayments(),
        "/certificates": (context) => const CertificatesScreen(),
        "/onboarding1": (context) => const OnBoardingScreenOne(),
        "/onboarding2": (context) => const OnBoardingScreenTwo(),
      },
    );
  }
}

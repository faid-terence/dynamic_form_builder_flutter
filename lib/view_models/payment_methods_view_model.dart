import 'package:dynamic_form_generator/services/payment_method_services.dart';
import 'package:flutter/material.dart';

class PaymentMethodsViewModel extends ChangeNotifier {
  final PaymentMethodsService _service = PaymentMethodsService();

  List<Map<String, dynamic>>? formFields;
  bool isLoading = true;
  String? errorMessage;

  Future<void> loadPaymentMethods() async {
    try {
      isLoading = true;
      notifyListeners();

      formFields = await _service.fetchPaymentMethods();
      errorMessage = null;
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveNumber(BuildContext context) async {
    try {
      await _service
          .savePaymentNumber('dummy_number'); // Replace with actual number

      if (context.mounted) {
        _showSuccessMessage(context);
        await Future.delayed(const Duration(seconds: 3));
        if (context.mounted) {
          Navigator.pushNamed(context, "/UserPayments");
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${error.toString()}')),
        );
      }
    }
  }

  void _showSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.green.shade600,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '"Number" saved successfully',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

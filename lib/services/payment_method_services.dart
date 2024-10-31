import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentMethodsService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Map<String, dynamic>>> fetchPaymentMethods() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/paymentMethods'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((field) => field as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load payment methods');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  Future<void> savePaymentNumber(String number) async {
    // Add API call to save payment number
    // For now, we'll just simulate an API call
    await Future.delayed(const Duration(seconds: 1));
    // Add validation or error handling as needed
  }
}

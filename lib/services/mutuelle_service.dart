import 'package:http/http.dart' as http;
import 'dart:convert';

class MutuelleService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Map<String, dynamic>>> fetchFormFields() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/mutuelleApplication'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((field) => field as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load form fields');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  Future<void> validateNID(String nid) async {
    // Add your NID validation logic here
    // This could include API calls to verify the NID
    if (nid != '1200280054610074') {
      throw Exception('Invalid NID');
    }
  }

  Future<void> processPayment(Map<String, dynamic> formData) async {
    // Add your payment processing logic here
    // This could include API calls to process the payment
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      // Add actual payment processing logic here
    } catch (error) {
      throw Exception('Payment failed: $error');
    }
  }
}

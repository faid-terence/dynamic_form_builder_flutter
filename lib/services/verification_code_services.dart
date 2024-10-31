import 'package:http/http.dart' as http;
import 'dart:convert';

class VerificationCodeService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Map<String, dynamic>>> fetchVerificationCode() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/verificationCode'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.map((field) => field as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load verification code');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  Future<void> saveVerificationCode(String code) async {
    // Add API call to save verification code
    // For now, we'll just simulate an API call
    await Future.delayed(const Duration(seconds: 1));
    // Add validation or error handling as needed
  }
}

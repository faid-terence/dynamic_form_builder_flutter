import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleRegistrationService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<Map<String, dynamic>>> fetchFormFields() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/vehicleRegistration'));

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
}

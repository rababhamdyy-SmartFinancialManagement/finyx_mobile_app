import 'dart:convert';
import 'package:http/http.dart' as http;

class HuggingFaceService {
  final String modelUrl = '';
  final String apiToken = '';

  Future<String> getModelPrediction(String inputText) async {
    try {
      final response = await http.post(
        Uri.parse(modelUrl),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'inputs': inputText}),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is List && decoded.isNotEmpty && decoded[0]['generated_text'] != null) {
          return decoded[0]['generated_text'];
        } else if (decoded is Map && decoded.containsKey('generated_text')) {
          return decoded['generated_text'];
        } else {
          return decoded.toString();
        }
      } else {
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Exception occurred: $e';
    }
  }
}

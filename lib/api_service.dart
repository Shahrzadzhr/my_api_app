import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://your-api-url.com";

  Future<Map<String, dynamic>> fetchData() async {
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<Map<String, dynamic>> getData(String url) async {
    http.Response urlResponse = await http.get(url);
    if (urlResponse.statusCode == 200) {
      return jsonDecode(urlResponse.body);
    } else {
      print(urlResponse.statusCode);
      return null;
    }
  }
}

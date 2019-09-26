import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  Future<Map<String, dynamic>> getData(var url) async {
//    var test = http.Client();
//    var rep = await test.get(url);
//    //print(rep.body);

    http.Response urlResponse = await http.get(url);
    if (urlResponse.statusCode != 200) {
      //print(urlResponse.statusCode);
      throw Exception('error ');
    } else {
      return jsonDecode(urlResponse.body);
    }
  }
}

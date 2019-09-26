import 'dart:convert';
import 'dart:io';

import 'repositories/api_client.dart';
import 'repositories/api_client_respository.dart';

main() async {
  HttpServer server = await HttpServer.bind('127.0.0.1', 8081);

  print('listening on localhost: ${server.port}');

  var e = await ApiClient();
  var q = await ApiClientRepository(apiClient: e);
  await q.getAccessToken();
  var d = q.fetchLeaderBoard();
  var x;

  d.listen((k) {
    x = k;
  });

  server.listen((HttpRequest req) {
    req.response.headers.add('Access-Control-Allow-Origin', '*');
    req.response
      ..write(jsonEncode(x))
      ..close();
  });
}

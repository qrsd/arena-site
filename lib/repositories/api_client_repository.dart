import 'package:meta/meta.dart';

import 'api_client.dart';

class ApiClientRepository {
  final ApiClient apiClient;

  ApiClientRepository({@required this.apiClient});

  Future<Map<String, dynamic>> fetchLeaderBoard() async {
    Map<String, dynamic> data =
        await apiClient.getData('http://localhost:8081');

    return data;
  }
}

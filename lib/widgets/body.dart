import 'package:flutter_web/material.dart';

import 'package:ArenaSite/models/leaderboard.dart';
import 'package:ArenaSite/repositories/api_client_repository.dart';
import 'package:ArenaSite/repositories/api_client.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();

    printData();
  }

  void printData() async {
    var e = await ApiClient();
    var q = await ApiClientRepository(apiClient: e);
    var d = await q.fetchLeaderBoard();
    //var g = LeaderBoard.fromJson(d).entries;
    //var d = f['entries'] as List;
    print(LeaderBoard.fromJson(d));

    //print('${g}');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

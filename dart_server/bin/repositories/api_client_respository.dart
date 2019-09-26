import 'package:meta/meta.dart';

import 'api_client.dart';
import 'apiKey.dart';

class ApiClientRepository {
  final ApiClient apiClient;
  String _accessToken;

  ApiClientRepository({@required this.apiClient});

  void getAccessToken() async {
    var data = await apiClient.getData(
        'https://us.battle.net/oauth/token?grant_type=client_credentials&client_id=$id&client_secret=$secret');

    _accessToken = data['access_token'];
  }

  Stream<Map<String, dynamic>> fetchLeaderBoard() async* {
    var temp;

    var data = await apiClient.getData(
        'https://us.api.blizzard.com/data/wow/pvp-season/28/pvp-leaderboard/3v3?namespace=dynamic-us&locale=en_US&access_token=$_accessToken');

    for (int i = 0; i < data['entries'].length; i++) {
      if (i != 0 && i % 200 == 0) {
        yield data;
      } else {
        String name = data['entries'][i]['character']['name'] ?? 'NULL';
        String realm =
            data['entries'][i]['character']['realm']['slug'] ?? 'NULL';
        if (name != 'NULL' && realm != 'NULL') {
          temp = await fetchPlayerInfo(
              data['entries'][i]['character']['name'].toLowerCase(),
              data['entries'][i]['character']['realm']['slug']);
          if (temp != null) {
            data['entries'][i].addAll(temp);
          }
        }
      }
    }
  }

  Future<Map<String, dynamic>> fetchPlayerInfo(
      String name, String realm) async {
    var _map = Map<String, dynamic>();
    var _azerite = await fetchPlayerAzerite(name, realm);
    var _talents = await fetchPlayerTalents(name, realm);
    var _profile = await fetchPlayerProfile(name, realm);

    if (_azerite != null) {
      _map.addAll(_azerite);
    }
    if (_talents != null) {
      _map.addAll(_talents);
    }
    if (_profile != null) {
      _map.addAll(_profile);
    }

    return _map;
  }

  Future<Map<String, dynamic>> fetchPlayerAzerite(
      String name, String realm) async {
    var _compList = ['head', 'neck', 'shoulders', 'chest'];
    var _traits = List<int>();
    var _essence = List<int>();
    var _map = Map<String, List<int>>();

    var data = await apiClient.getData(
        'https://us.api.blizzard.com/profile/wow/character/$realm/$name/equipment?namespace=profile-us&locale=en_US&access_token=$_accessToken');
    if (data != null) {
      data.forEach((k, v) {
        if (k == 'equipped_items') {
          data[k].forEach((v2) {
            if (_compList.contains(v2['slot']['name'].toLowerCase())) {
              v2.forEach((k3, v3) {
                if (k3 == 'azerite_details') {
                  v3.forEach((k4, v4) {
                    if (k4 == 'selected_powers') {
                      v4.asMap().forEach((k5, v5) {
                        if (v5.containsKey('spell_tooltip') &&
                            (k5 == 3 || k5 == 4)) {
                          _traits.add(v5['spell_tooltip']['spell']['id'] ?? 0);
                        }
                      });
                    }
                    if (k4 == 'selected_essences') {
                      v4.asMap().forEach((k5, v5) {
                        if (v5.containsKey('main_spell_tooltip')) {
                          _essence.add(
                              v5['main_spell_tooltip']['spell']['id'] ?? 0);
                        } else if (v5.containsKey('passive_spell_tooltip')) {
                          _essence.add(
                              v5['passive_spell_tooltip']['spell']['id'] ?? 0);
                        }
                      });
                    }
                  });
                }
              });
            }
          });
        }
      });
      _map['traits'] = _traits;
      _map['essence'] = _essence;
    }

    return _map;
  }

  Future<Map<String, dynamic>> fetchPlayerTalents(
      String name, String realm) async {
    var _honor = List<int>();
    var _talents = List<int>();
    var _map = Map<String, List<int>>();
    int _activeID;

    var data = await apiClient.getData(
        'https://us.api.blizzard.com/profile/wow/character/$realm/$name/specializations?namespace=profile-us&locale=en_US&access_token=$_accessToken');
    if (data != null) {
      _activeID = data['active_specialization']['id'];
      data.forEach((k, v) {
        if (k == 'specializations') {
          data[k].forEach((v2) {
            if (v2['specialization']['id'] == _activeID) {
              v2.forEach((k3, v3) {
                if (k3 == 'talents') {
                  v3.forEach((v4) {
                    _talents.add(v4['spell_tooltip']['spell']['id'] ?? 0);
                  });
                }
                if (k3 == 'pvp_talent_slots') {
                  v3.forEach((v4) {
                    _honor.add(
                        v4['selected']['spell_tooltip']['spell']['id'] ?? 0);
                  });
                }
              });
            }
          });
        }
      });
      _map['honor'] = _honor;
      _map['talents'] = _talents;
    }

    return _map;
  }

  Future<Map<String, dynamic>> fetchPlayerProfile(
      String name, String realm) async {
    var _map = Map<String, String>();

    var data = await apiClient.getData(
        'https://us.api.blizzard.com/profile/wow/character/$realm/$name?namespace=profile-us&locale=en_US&access_token=$_accessToken');

    if (data != null) {
      _map['race'] = data['race']['name'];
      _map['gender'] = data['gender']['name'];
      _map['class'] = data['character_class']['name'];
      _map['spec'] = data['active_spec']['name'];
    }

    return _map;
  }
}

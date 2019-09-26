import 'package:intl/intl.dart';

class LeaderBoard {
  String bracket;
  List<Entries> entries;

  LeaderBoard({this.bracket, this.entries});

  @override
  String toString() {
    return 'bracket: $bracket \nentries:${entries}\n';
  }

  LeaderBoard.fromJson(Map<String, dynamic> jsonMap) {
    bracket = jsonMap['name'] ?? 'nothing';
    if (jsonMap['entries'] != null) {
      entries = List<Entries>();
      jsonMap['entries'].forEach((e) {
        entries.add(Entries.fromJson(e));
      });
    }
  }
}

class Entries {
  final int rank;
  final int rating;
  final String faction;
  final String name;
  final String playerClass;
  final String playerSpec;
  final String playerRace;
  final String playerGender;
  final String realm;
  final MatchStats stats;
  final List azeriteTraits;
  final List essences;
  final List talents;
  final List honorTalents;

  Entries({
    this.rank,
    this.rating,
    this.faction,
    this.name,
    this.playerClass,
    this.playerGender,
    this.playerRace,
    this.playerSpec,
    this.realm,
    this.stats,
    this.azeriteTraits,
    this.essences,
    this.talents,
    this.honorTalents,
  });

  @override
  String toString() {
    return '$rank $faction $name $realm azerite: $azeriteTraits essences: $essences talents: $talents honor talents: $honorTalents rating: $rating stats: $stats player: $playerGender $playerRace $playerSpec $playerClass\n';
  }

  factory Entries.fromJson(Map<String, dynamic> jsonMap) {
    return Entries(
      rank: jsonMap['rank'] as int,
      faction:
          toBeginningOfSentenceCase(jsonMap['faction']['type'].toLowerCase()),
      name: jsonMap['character']['name'],
      realm: toBeginningOfSentenceCase(jsonMap['character']['realm']['slug']),
      rating: jsonMap['rating'] as int,
      playerClass: jsonMap['class'],
      playerGender: jsonMap['gender'],
      playerRace: jsonMap['race'],
      playerSpec: jsonMap['spec'],
      stats: MatchStats.fromJson(jsonMap),
      azeriteTraits: jsonMap['traits'],
      essences: jsonMap['essence'],
      talents: jsonMap['talents'],
      honorTalents: jsonMap['honor'],
    );
  }
}

class MatchStats {
  final int played;
  final int won;
  final int lost;

  MatchStats({this.played, this.won, this.lost});

  @override
  String toString() {
    return 'played: $played, won: $won, lost: $lost';
  }

  factory MatchStats.fromJson(Map<String, dynamic> jsonMap) {
    return MatchStats(
        played: jsonMap['season_match_statistics']['played'] as int,
        won: jsonMap['season_match_statistics']['won'] as int,
        lost: jsonMap['season_match_statistics']['lost'] as int);
  }
}

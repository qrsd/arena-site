import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:ArenaSite/models/models.dart';

abstract class ApiState extends Equatable {
  ApiState([List props = const []]) : super(props);
}

class ApiEmpty extends ApiState {}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final LeaderBoard leaderboard;

  ApiLoaded({@required this.leaderboard})
      : assert(leaderboard != null),
        super([leaderboard]);
}

class ApiError extends ApiState {}

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  ApiEvent([List props = const []]) : super(props);
}

class fetchLeaderBoard extends ApiEvent {
  fetchLeaderBoard();
}

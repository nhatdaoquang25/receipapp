import 'package:equatable/equatable.dart';

import '../../models/feed_card_model.dart';
import '../../models/user_model.dart';

abstract class FeedCardState extends Equatable {
  @override
  List<Object> get props => [];
}

class FeedCardInitial extends FeedCardState {}

class FeedCardLoadInProgress extends FeedCardState {}

class FeedCardLoadSuccess extends FeedCardState {
  final List<FeedCardModel> recipes;
  final List<UserModel> authors;

  FeedCardLoadSuccess(this.recipes, this.authors);
  @override
  List<Object> get props => [recipes, authors];
}

class FeedCardLoadFailure extends FeedCardState {
  final String error;

  FeedCardLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}

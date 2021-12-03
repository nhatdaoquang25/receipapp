import 'package:equatable/equatable.dart';

abstract class FeedCardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FeedCardDataRequested extends FeedCardEvent {}

import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants_text.dart';
import '../../models/feed_card_model.dart';
import '../../models/user_model.dart';
import '../../services/feed_card_service.dart';
import 'feed_card_event.dart';
import 'feed_card_state.dart';

class FeedCardBloc extends Bloc<FeedCardEvent, FeedCardState> {
  final FeedCardService feedCardService;
  final Connectivity connect;
  FeedCardBloc({required this.connect, required this.feedCardService})
      : super(FeedCardInitial());

  List<FeedCardModel> recipes = [];
  List<UserModel> authors = [];
  List result = [];

  @override
  Stream<FeedCardState> mapEventToState(FeedCardEvent event) async* {
    switch (event.runtimeType) {
      case FeedCardDataRequested:
        yield FeedCardLoadInProgress();
        ConnectivityResult? connected = await connect.checkConnectivity();
        if (connected == ConnectivityResult.none) {
          yield FeedCardLoadFailure(FeedText.noNetError);
        } else {
          result = await feedCardService.getFeeds();
          recipes = result.first;
          authors = result.last;
          if (recipes.isNotEmpty) {
            yield FeedCardLoadSuccess(recipes, authors);
          } else {
            yield FeedCardLoadFailure(FeedText.noFeedError);
          }
        }
        break;
    }
  }
}

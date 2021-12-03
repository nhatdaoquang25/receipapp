import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/src/blocs/feed/feed_card_bloc.dart';
import 'package:mobile_app/src/blocs/feed/feed_card_event.dart';
import 'package:mobile_app/src/blocs/feed/feed_card_state.dart';
import 'package:mobile_app/src/models/feed_card_model.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/services/feed_card_service.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../mock/mock_connectivity.dart';
import '../../mock/mock_feed_card_service.dart';

void main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();

  FeedCardService feedCardService;
  Connectivity connect;
  FeedCardBloc? feedCardBloc;
  List result = [];
  List<FeedCardModel> recipes = [];
  List<UserModel> authors = [];
  setUp(() async {
    feedCardService = MockFeedCardService(true);
    connect = MockConnectivity(true);
    result = await feedCardService.getFeeds();
    feedCardBloc =
        FeedCardBloc(feedCardService: feedCardService, connect: connect);
  });
  tearDown(() {
    feedCardBloc?.close();
  });

  blocTest(
    'emits [] when no event is added',
    build: () {
      feedCardService = MockFeedCardService(false);
      connect = MockConnectivity(false);
      return FeedCardBloc(connect: connect, feedCardService: feedCardService);
    },
    expect: () => [],
  );
  blocTest(
    'emits [FeedCardLoadInProgress] then [FeedCardLoadSuccess] when [FeedCardDataRequested] is called.',
    build: () {
      feedCardService = MockFeedCardService(true);
      connect = MockConnectivity(true);
      recipes = result.first;
      authors = result.last;
      return FeedCardBloc(feedCardService: feedCardService, connect: connect);
    },
    act: (FeedCardBloc bloc) => bloc.add(
      FeedCardDataRequested(),
    ),
    expect: () => [
      FeedCardLoadInProgress(),
      FeedCardLoadSuccess(recipes, authors),
    ],
  );
  blocTest(
    'emits [FeedCardLoadInProgress] then [FeedCardLoadFailure] when [FeedCardDataRequested] and there are no feed exists.',
    build: () {
      feedCardService = MockFeedCardService(false);
      connect = MockConnectivity(true);
      return FeedCardBloc(feedCardService: feedCardService, connect: connect);
    },
    act: (FeedCardBloc bloc) => bloc.add(
      FeedCardDataRequested(),
    ),
    expect: () => [
      FeedCardLoadInProgress(),
      FeedCardLoadFailure('There are no new feeds at the moment!'),
    ],
  );
  blocTest(
    'emits [FeedCardLoadInProgress] then [FeedCardLoadFailure] when [FeedCardDataRequested] and there are no internet connection.',
    build: () {
      feedCardService = MockFeedCardService(false);
      connect = MockConnectivity(false);
      return FeedCardBloc(feedCardService: feedCardService, connect: connect);
    },
    act: (FeedCardBloc bloc) => bloc.add(
      FeedCardDataRequested(),
    ),
    expect: () => [
      FeedCardLoadInProgress(),
      FeedCardLoadFailure(
          'Something went wrong, check your internet connection!'),
    ],
  );
}

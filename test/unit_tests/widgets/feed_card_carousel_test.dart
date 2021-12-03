import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/feed/feed_card_bloc.dart';
import 'package:mobile_app/src/blocs/feed/feed_card_state.dart';
import 'package:mobile_app/src/screens/feed_screen.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/network_image.dart';
import '../../mock/mock_connectivity.dart';
import '../../mock/mock_feed_card_service.dart';

main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();
  final connect = MockConnectivity(true);
  final feedCardService = MockFeedCardService(true);
  final feedCardBloc =
      FeedCardBloc(feedCardService: feedCardService, connect: connect);
  final widget = MaterialApp(
    home: Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: feedCardBloc,
          ),
        ],
        child: FeedScreen(),
      ),
    ),
  );

  testWidgets('Should render tablet feed card carousel components',
      (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(widget);
      feedCardBloc.emit(FeedCardLoadInProgress());
      await tester.pump();
      final indicatorFinder = find.byType(CircularProgressIndicator);
      expect(indicatorFinder, findsOneWidget);
      final List result = await feedCardService.getFeeds();
      feedCardBloc.emit(FeedCardLoadSuccess(result.first, result.last));
      await tester.pumpAndSettle();
      final listViewFinder = find.byType(ListView);
      expect(listViewFinder, findsOneWidget);
    });
  });
  testWidgets('Should render mobile feed card carousel components',
      (tester) async {
    await mockNetworkImages(() async {
      tester.binding.window.physicalSizeTestValue = Size(360, 680);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      feedCardBloc.emit(FeedCardLoadInProgress());
      await tester.pump();
      final indicatorFinder = find.byType(CircularProgressIndicator);
      expect(indicatorFinder, findsOneWidget);
      final List result = await feedCardService.getFeeds();
      feedCardBloc.emit(FeedCardLoadSuccess(result.first, result.last));
      await tester.pumpAndSettle();
      final pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);
    });
  });
}

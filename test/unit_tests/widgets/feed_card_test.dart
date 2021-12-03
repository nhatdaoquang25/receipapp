import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/feed/feed_card_bloc.dart';
import 'package:mobile_app/src/blocs/feed/feed_card_state.dart';
import 'package:mobile_app/src/screens/feed_screen.dart';
import 'package:mobile_app/src/widgets/feed_card_content.dart';
import 'package:mobile_app/src/widgets/feed_card_header.dart';

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
  testWidgets('Should render mobile feed card components', (tester) async {
    await mockNetworkImages(() async {
      tester.binding.window.physicalSizeTestValue = Size(360, 680);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      final List result = await feedCardService.getFeeds();
      feedCardBloc.emit(FeedCardLoadSuccess(result.first, result.last));
      await tester.pumpAndSettle();
      final imageFinder = tester
          .widgetList<Image>(find.byType(Image))
          .first
          .image as NetworkImage;
      final feedCardHeaderFinder = find.byType(FeedCardHeader);
      final feedCardContentFinder = find.byType(FeedCardContent);
      expect(imageFinder.url,
          'https://www.howtocook.recipes/wp-content/uploads/2020/09/Sugar-cookie-recipe-with-icing.jpg');
      expect(feedCardHeaderFinder, findsOneWidget);
      expect(feedCardContentFinder, findsOneWidget);
    });
  });
  testWidgets('Should render tablet feed card components', (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(widget);
      final List result = await feedCardService.getFeeds();
      feedCardBloc.emit(FeedCardLoadSuccess(result.first, result.last));
      await tester.pumpAndSettle();
      final imageFinder = tester
          .widgetList<Image>(find.byType(Image))
          .first
          .image as NetworkImage;
      final feedCardHeaderFinder = find.byType(FeedCardHeader);
      final feedCardContentFinder = find.byType(FeedCardContent);
      expect(imageFinder.url,
          'https://www.howtocook.recipes/wp-content/uploads/2020/09/Sugar-cookie-recipe-with-icing.jpg');
      expect(feedCardHeaderFinder, findsOneWidget);
      expect(feedCardContentFinder, findsOneWidget);
    });
  });
}

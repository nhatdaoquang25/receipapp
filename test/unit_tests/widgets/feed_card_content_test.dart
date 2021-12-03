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
  testWidgets('Should render mobile feed card contents', (tester) async {
    await mockNetworkImages(() async {
      tester.binding.window.physicalSizeTestValue = Size(360, 680);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      final List result = await feedCardService.getFeeds();
      feedCardBloc.emit(FeedCardLoadSuccess(result.first, result.last));
      await tester.pumpAndSettle();
      final favoriteIconFinder =
          tester.widgetList<Image>(find.byType(Image)).last.image as AssetImage;
      final saveButtonFinder = find.widgetWithText(OutlinedButton, 'Save');
      expect(favoriteIconFinder.assetName, 'assets/icons/favorite_icon.png');
      expect(find.text('mock title'), findsOneWidget);
      expect(find.text('mock description'), findsOneWidget);
      expect(find.text('707 Likes'), findsOneWidget);
      expect(find.text('30 Comments'), findsOneWidget);
      expect(saveButtonFinder, findsOneWidget);
    });
  });
  testWidgets('Should render tablet feed card contents', (tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(widget);
      final List result = await feedCardService.getFeeds();
      feedCardBloc.emit(FeedCardLoadSuccess(result.first, result.last));
      await tester.pumpAndSettle();
      final favoriteIconFinder =
          tester.widgetList<Image>(find.byType(Image)).last.image as AssetImage;
      final saveButtonFinder = find.widgetWithText(OutlinedButton, 'Save');
      expect(favoriteIconFinder.assetName, 'assets/icons/favorite_icon.png');
      expect(find.text('mock title'), findsOneWidget);
      expect(find.text('mock description'), findsOneWidget);
      expect(find.text('707 Likes'), findsOneWidget);
      expect(find.text('30 Comments'), findsOneWidget);
      expect(saveButtonFinder, findsOneWidget);
    });
  });
}

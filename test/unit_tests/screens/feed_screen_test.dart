import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/feed/feed_card_bloc.dart';
import 'package:mobile_app/src/screens/feed_screen.dart';
import 'package:mobile_app/src/services/feed_card_service.dart';
import 'package:mobile_app/src/widgets/feed_card_carousel.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../mock/mock_connectivity.dart';
import '../../mock/mock_feed_card_service.dart';

main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();
  final FeedCardService feedCardService = MockFeedCardService(false);
  final Connectivity connect = MockConnectivity(false);
  final carouselBloc =
      FeedCardBloc(connect: connect, feedCardService: feedCardService);
  final widget = MaterialApp(
    home: MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: carouselBloc,
        ),
      ],
      child: FeedScreen(),
    ),
  );

  testWidgets('Should render mobile food recipe screen widgets',
      (tester) async {
    tester.binding.window.physicalSizeTestValue = Size(400, 720);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(widget);

    final cardCarouselFinder = find.byType(FeedCardCarousel);
    expect(cardCarouselFinder, findsOneWidget);
  });
  testWidgets('Should render tablet food recipe screen widgets',
      (tester) async {
    await tester.pumpWidget(widget);

    final cardCarouselFinder = find.byType(FeedCardCarousel);
    expect(cardCarouselFinder, findsOneWidget);
  });
}

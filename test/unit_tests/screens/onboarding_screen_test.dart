import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/screens/onboarding_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

main() async {
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: OnboardingScreen(),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );

  group('Mobile onboarding screen', () {
    testWidgets('Clicked on the screen and should move to login screen',
        (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();
      verify(() => mockObserver.didPush(any(), any()));
    });
  });

  group('Tablet Onboarding screen', () {
    testWidgets(
        'Should render screen with title and sub title and background image',
        (tester) async {
      await tester.pumpWidget(widget);
      final titleApp =
          find.text("Join over 50 millions people\n sharing recipes everyday");
      final subTitleApp = find.text(
          'Never run out of ideas again. Try new foods,\n ingredients, cooking style, and more');
      final Image imageWidget = Image.asset(
          'assets/images/backgroundloading.png',
          package: 'test_package');
      assert(imageWidget.image is AssetImage);
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(titleApp, findsOneWidget);
      expect(subTitleApp, findsOneWidget);
      expect(assetImage.keyName,
          'packages/test_package/assets/images/backgroundloading.png');
    });
    testWidgets('Find Button "Learn more', (tester) async {
      await tester.pumpWidget(widget);
      final titleApp = find.widgetWithText(OutlinedButton, 'Learn more');
      expect(titleApp, findsOneWidget);
    });

    testWidgets(
        'Find Button "Join Scratch", clicked and should move to new screen ',
        (tester) async {
      await tester.pumpWidget(widget);
      await tester.tap(find.widgetWithText(TextButton, 'Join Scratch'));
      await tester.pumpAndSettle();
      verify(() => mockObserver.didPush(any(), any()));
    });
  });
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/screens/userprofile_screen.dart';
import 'package:mobile_app/src/widgets/profile_infomation_card.dart';
import 'package:mobile_app/src/widgets/profile_tabbar.dart';
import 'package:mobile_app/src/widgets/top_bar_tablet.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/network_image.dart';
import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

main() async {
  setUpFirebaseAuthMocks();
 

  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: UserProfileScreen(),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );

  group('Mobile profile screen', () {
    testWidgets('Find text title in profile screen', (tester) async {
      await mockNetworkImages(() async {
        tester.binding.window.physicalSizeTestValue = Size(480, 760);
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        await tester.pumpWidget(widget);
        final numberFollowing = find.text("My Kitchen");
        expect(numberFollowing, findsOneWidget);
      });
    });
    testWidgets('Find widget in profile screen', (tester) async {
      await mockNetworkImages(() async {
        tester.binding.window.physicalSizeTestValue = Size(480, 760);
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
        await tester.pumpWidget(widget);
        final infomationCard = find.byType(ProfileInfomationCard);
        expect(infomationCard, findsOneWidget);
        final tabBarProfile = find.byType(TabBarProfile);
        expect(tabBarProfile, findsOneWidget);
      });
    });
  });

  group('Tablet profile screen', () {
    testWidgets('Find widget in profile screen', (tester) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(widget);
        final topBar = find.byType(TopBar);
        expect(topBar, findsOneWidget);
        final infomationCard = find.byType(ProfileInfomationCard);
        expect(infomationCard, findsOneWidget);
        final tabBarProfile = find.byType(TabBarProfile);
        expect(tabBarProfile, findsOneWidget);
      });
    });
  });
}

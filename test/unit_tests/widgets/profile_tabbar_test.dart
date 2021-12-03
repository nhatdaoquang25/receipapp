import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/profile_recipes_tab.dart';
import 'package:mobile_app/src/widgets/profile_tabbar.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/network_image.dart';
import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

main() async {
  setUpFirebaseAuthMocks();
  setUp(() {
    registerFallbackValue(MyFakeType());
  });

  await Firebase.initializeApp();
  final mockObserver = MockNavigatorObserver();


  final widget = MaterialApp(
    home: Scaffold(
      body: TabBarProfile(),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Should render tab Following in TabBarProfile ',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(widget);
      final tab = find.byType(Tab);
      final tabFollowing =
          find.descendant(of: tab, matching: find.text('Following'));
      expect(tabFollowing, findsOneWidget);
      final tabSaved = find.descendant(of: tab, matching: find.text('Saved'));
      expect(tabSaved, findsOneWidget);
      final tabRecipes =
          find.descendant(of: tab, matching: find.text('Recipes'));
      expect(tabRecipes, findsOneWidget);
    });
  });
  testWidgets('Should render Widget RecipesTab in TabBarProfile ',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(widget);
      final gridView = find.byType(TabBarView);
      final categoryItem =
          find.descendant(of: gridView, matching: find.byType(RecipesTab));
      expect(categoryItem, findsWidgets);
    });
  });
}

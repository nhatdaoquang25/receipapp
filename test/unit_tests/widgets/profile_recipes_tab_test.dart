
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/profile_categoryitem.dart';
import 'package:mobile_app/src/widgets/profile_recipes_tab.dart';
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
      body: RecipesTab(),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Should render user GridView in RecipesTab ',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(widget);
      final gridView = find.byType(GridView);
      expect(gridView, findsOneWidget);
    });
  });
  testWidgets('Should render Widget CategoryItem in RecipesTab ',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(widget);
      final gridView = find.byType(GridView);
      final categoryItem =
          find.descendant(of: gridView, matching: find.byType(CategoryItem));
      expect(categoryItem, findsWidgets);
    });
  });
}

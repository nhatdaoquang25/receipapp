import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/fake_data.dart';
import 'package:mobile_app/src/widgets/profile_categoryitem.dart';


import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/network_image.dart';
import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

main() async {
  int id = 1;
  String content = 'Food';
  String urlPicture = '';
  final category = Category(id: id, content: content, urlPicture: urlPicture);
  setUpFirebaseAuthMocks();
  setUp(() {
    registerFallbackValue(MyFakeType());
  });

  await Firebase.initializeApp();
  final mockObserver = MockNavigatorObserver();
  

  final widget = MaterialApp(
    home: Scaffold(
      body: CategoryItem(
        category: category,
      ),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Should render content in CategoryItem ',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await tester.pumpWidget(widget);
      final albumCardFinder = find.byType(CategoryItem);
      final albumTitleFinder =
          find.descendant(of: albumCardFinder, matching: find.text(content));

      expect(albumTitleFinder, findsOneWidget);
    });
  });
}

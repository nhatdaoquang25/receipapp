import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/create_recipe/post_to_feed_button.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() {
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: Scaffold(body: PostToFeedButton()),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Shuold render Post to Feed button with correct button',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.widgetWithText(TextButton, 'Post to Feed'));
    await tester.pump();
    verify(() => mockObserver.didPush(any(), any()));
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/create_recipe/back_button.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() {
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: Scaffold(body: RecipeBackButton()),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Check tapping back button inkwell', (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Should render back icon buttons and title', (tester) async {
    await tester.pumpWidget(widget);
    final buttonImage =
        tester.widget<Image>(find.byType(Image)).image as AssetImage;
    final titleRecipes = find.text('Back to My Recipes');
    expect(buttonImage.assetName, 'assets/icons/back_icon.png');
    expect(titleRecipes, findsOneWidget);
  });
}

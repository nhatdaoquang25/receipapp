import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/create_recipe/add_direction_box.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() {
  List<String> test = [''];
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: Scaffold(
        body: AddCookRecipeBox(
      cookRecipeList: test,
    )),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Should render add icon button with correct icon button',
      (tester) async {
    await tester.pumpWidget(widget);
    final buttonImage =
        tester.widget<Image>(find.byType(Image)).image as AssetImage;
    expect(buttonImage.assetName, 'assets/icons/add_icon.png');
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Should render text widget with correct text', (tester) async {
    await tester.pumpWidget(widget);
    final testwidgets = find.byType(Text);
    expect(testwidgets, findsOneWidget);
  });
}

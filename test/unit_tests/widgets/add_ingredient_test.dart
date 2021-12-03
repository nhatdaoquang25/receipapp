import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/create_recipe_model.dart';
import 'package:mobile_app/src/widgets/create_recipe/add_ingredient_box.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() {
  IngredientModel ingredientModel = IngredientModel(
      ingredientText: '', ingredientImage: File('assets/icons/add_icon.png'));
  List<IngredientModel> ingredient = [ingredientModel];
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: Scaffold(
        body: AddIngredient(
      ingredientList: ingredient,
    )),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Should render add icon with correct icon', (tester) async {
    await tester.pumpWidget(widget);
    final AssetImage imageButtonIngredient = AssetImage(
      'assets/icons/add_icon.png',
    );
    final List<Image> imageButtonIngredientFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageButtonIngredientFinder[0].image, imageButtonIngredient);
  });
  testWidgets('Should render text widgets', (tester) async {
    await tester.pumpWidget(widget);
    final textwidgets = find.byType(Text);
    expect(textwidgets, findsOneWidget);
  });
}

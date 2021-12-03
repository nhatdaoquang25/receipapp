import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_event.dart';
import 'package:mobile_app/src/models/create_recipe_model.dart';
import 'package:mobile_app/src/widgets/create_recipe/save_recipe_button.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();
  IngredientModel abc = IngredientModel(
      ingredientImage: File('/assets/icons/add_icon.png'),
      ingredientText: '123');
  List<String> durationList = ['123'];
  String recipeName = '123';
  List<File> galleryImage = [File('/assets/icons/add_icon.png')];
  List<IngredientModel> ingredientList = [abc];
  File recipeImage = File('1233');
  String servingTime = '123';
  String nutrition = '123';
  String tag = '123';
  final bloc = CreateRecipeBloc();
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: bloc),
        ],
        child: SaveRecipeButton(
            durationList: durationList,
            recipeName: recipeName,
            galleryImage: galleryImage,
            ingredientList: ingredientList,
            recipeImage: recipeImage,
            servingTime: servingTime,
            nutrition: nutrition,
            tag: tag),
      ),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets(
      'Should render [Save Recipe] text, [dropdown] icon and [dropdown] button',
      (tester) async {
    await tester.pumpWidget(widget);
    final saveRecipeText = find.text('Save Recipe');
    final dropdownIcon = find.byType(Icon);
    final dropdownButton = find.byType(TextButton);
    expect(dropdownButton, findsOneWidget);
    expect(saveRecipeText, findsOneWidget);
    expect(dropdownIcon, findsOneWidget);
  });
  testWidgets('Shuold render Save Recipe button with correct button',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.widgetWithText(TextButton, "Save Recipe"));
    bloc.add(CreateRecipeSaved(
        recipeName: recipeName,
        recipeImage: recipeImage,
        galleryImage: galleryImage,
        ingredientList: ingredientList,
        durationList: durationList,
        servingTime: servingTime,
        nutrition: nutrition,
        tag: tag));
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
}

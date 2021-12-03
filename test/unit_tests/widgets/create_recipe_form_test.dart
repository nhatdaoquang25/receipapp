import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_event.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_state.dart';
import 'package:mobile_app/src/widgets/create_recipe/create_recipe_form.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  final bloc = CreateRecipeBloc();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: bloc),
        ],
        child: CreateRecipeForm(),
      ),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Should render all text in CreateRecipeForm widgets ',
      (tester) async {
    await tester.pumpWidget(widget);
    final recipeNameText = find.text('Recipe Name');
    final tutorialText =
        find.widgetWithText(TextFormField, 'Write Down Recipe Name');
    final galleryText = find.text('Gallery').first;
    final buttonGalleryText = find.text('Gallery').last;
    final ingredientText = find.text('Ingredients');
    final adddIngredientText = find.text('Add Ingredient');
    final howToCookText = find.text('How to Cook');
    final addDirectionText = find.text('Add Directions');
    final additonalInfoText = find.text('Additional Info');
    final addInfoText = find.text('Add Info');
    final saveToText = find.text('Save to');
    expect(saveToText, findsOneWidget);
    expect(addInfoText, findsOneWidget);
    expect(additonalInfoText, findsOneWidget);
    expect(addDirectionText, findsOneWidget);
    expect(howToCookText, findsOneWidget);
    expect(adddIngredientText, findsOneWidget);
    expect(ingredientText, findsOneWidget);
    expect(buttonGalleryText, findsOneWidget);
    expect(galleryText, findsOneWidget);
    expect(recipeNameText, findsOneWidget);
    expect(tutorialText, findsOneWidget);
  });
  testWidgets('Should render add icon with correct icon', (tester) async {
    await tester.pumpWidget(widget);
    final AssetImage imageRecipeName = AssetImage(
      'assets/icons/add_icon.png',
    );
    final List<Image> imageRecipeNameFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageRecipeNameFinder[0].image, imageRecipeName);

    final AssetImage imageButtonGallery = AssetImage(
      'assets/icons/edit_icon.png',
    );
    final List<Image> imageButtonGalleryFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageButtonGalleryFinder[1].image, imageButtonGallery);
    final AssetImage imageButtonGalleryAdd = AssetImage(
      'assets/icons/add_icon.png',
    );
    final List<Image> imageButtonGalleryAddFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageButtonGalleryAddFinder[2].image, imageButtonGalleryAdd);
    final AssetImage imageButtonIngredientEdit = AssetImage(
      'assets/icons/edit_icon.png',
    );
    final List<Image> imageButtonIngredientEditFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageButtonIngredientEditFinder[3].image, imageButtonIngredientEdit);
    final AssetImage imageButtonIngredientAdd = AssetImage(
      'assets/icons/add_icon.png',
    );
    final List<Image> imageButtonIngredientAddFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageButtonIngredientAddFinder[4].image, imageButtonIngredientAdd);
    final AssetImage imageIngredient = AssetImage(
      'assets/icons/image_add_icon.png',
    );
    final List<Image> imageIngredientFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageIngredientFinder[5].image, imageIngredient);
    final AssetImage imageHowToCookEdit = AssetImage(
      'assets/icons/edit_icon.png',
    );
    final List<Image> imageHowToCookEditFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageHowToCookEditFinder[6].image, imageHowToCookEdit);
    final AssetImage imageHowToCookAdd = AssetImage(
      'assets/icons/add_icon.png',
    );
    final List<Image> imageHowToCookAddFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageHowToCookAddFinder[7].image, imageHowToCookAdd);
    final AssetImage imageButtonInfoEdit = AssetImage(
      'assets/icons/edit_icon.png',
    );
    final List<Image> imageButtonInfoEditFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageButtonInfoEditFinder[8].image, imageButtonInfoEdit);
    final AssetImage imageButtonInfoAdd = AssetImage(
      'assets/icons/add_icon.png',
    );
    final List<Image> imageButtonInfoAddFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(imageButtonInfoAddFinder[9].image, imageButtonInfoAdd);
  });
  testWidgets(
      'Should render textButton, InkWell button in CreateRecipeForm widgets ',
      (tester) async {
    await tester.pumpWidget(widget);
    final recipeNameTextButton = find.byType(TextButton).first;
    await tester.enterText(
        find.byType(TextFormField).first, "Write Down Recipe Name");
    final galleryButton = find.byType(InkWell).first;
    final ingredientButton = find.byType(InkWell).last;
    final ingredientTextButton = find.byType(TextButton).last;
    final addDirectionButton = find.byType(InkWell).last;
    final addInfoButton = find.byType(InkWell).last;
    expect(addInfoButton, findsOneWidget);
    expect(addDirectionButton, findsOneWidget);
    expect(ingredientTextButton, findsOneWidget);
    expect(ingredientButton, findsOneWidget);
    expect(galleryButton, findsOneWidget);
    expect(recipeNameTextButton, findsOneWidget);
  });
  testWidgets(
      'Should render recipe image picked and gallery image picked with correct image',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(TextButton).first);
    bloc.emit(CreateRecipeImagePickSuccess(recipeImage: File('123')));
    await tester.pumpAndSettle();
    final textContainer = find.descendant(
        of: find.byType(Container), matching: find.byType(ClipRRect));
    expect(textContainer, findsOneWidget);
    bloc.emit(CreateRecipeGalleryImagePickSuccess(
        galleryImage: [File('assets/icons/edit_icon.png')]));
    await tester.pumpAndSettle();
    final textSized = find.descendant(
        of: find.byType(Container), matching: find.byType(StaggeredGridView));
    expect(textSized, findsOneWidget);
  });
  testWidgets('Shuold render gallery button with correct button',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
    final textShowImage = find.byType(ListTile);
    expect(textShowImage, findsWidgets);
  });
  testWidgets('Should render add ingredient button with correct button',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(InkWell).last);
    bloc.add(CreateRecipeIngredientAdded(
      ingredientImage: File('assets/icons/edit_icon.png'),
      ingredientText: '123',
    ));
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Shound render add direction button with correct button',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(InkWell).last);
    bloc.add(CreateRecipeDirectionAdded(direction: '123'));
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Shuold render add info button with correct button',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(InkWell).last);
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Shuold render add ingredient image button with correct button',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.byType(TextButton).last);
    bloc.add(CreateRecipeIngredientImagePicked());
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
}

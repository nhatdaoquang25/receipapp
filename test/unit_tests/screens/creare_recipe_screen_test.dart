import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_bloc.dart';
import 'package:mobile_app/src/screens/create_recipe_screen.dart';
import 'package:mobile_app/src/widgets/create_recipe/back_button.dart';
import 'package:mobile_app/src/widgets/create_recipe/create_recipe_form.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/router_help.dart' as setRoute;
import '../widgets/login_form_test.dart';

void main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();
  final _createRecipeBloc = CreateRecipeBloc();
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() {
    registerFallbackValue(MyFakeType());
  });
  final widget = MaterialApp(
    home: BlocProvider.value(
      value: _createRecipeBloc,
      child: CreateRecipeScreen(),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Should render createRecipe mobile screen with correct screen.',
      (tester) async {
    tester.binding.window.physicalSizeTestValue = Size(400, 720);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(widget);
    final titleMobile = find.text('New Recipe');
    final recipeBackButton = find.byType(RecipeBackButton);
    final createRecipeForm = find.byType(CreateRecipeForm);
    expect(titleMobile, findsOneWidget);
    expect(recipeBackButton, findsOneWidget);
    expect(createRecipeForm, findsOneWidget);
  });
  testWidgets('Should render createRecipe tablet screen with correct screen.',
      (tester) async {
    await tester.pumpWidget(widget);
    final titleTablet = find.text('Create New Recipe');
    final recipeBackButtonTablet = find.byType(RecipeBackButton);
    final createRecipeFormTablet = find.byType(CreateRecipeForm);
    expect(titleTablet, findsOneWidget);
    expect(recipeBackButtonTablet, findsOneWidget);
    expect(createRecipeFormTablet, findsOneWidget);
  });
}

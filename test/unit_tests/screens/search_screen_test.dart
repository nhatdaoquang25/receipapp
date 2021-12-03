import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/recipe/recipe_bloc.dart';
import 'package:mobile_app/src/screens/search_screen.dart';
import 'package:mobile_app/src/services/search_service.dart';
import 'package:mobile_app/src/widgets/search_box.dart';
import 'package:mocktail/mocktail.dart';

class MockRecipeService extends Mock implements RecipeService {}

main() async {
  final mockSearchServices = MockRecipeService();
  final recipeBloc = RecipeBloc(recipeService: mockSearchServices);
  final widget = MaterialApp(
    home: Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: recipeBloc),
        ],
        child: SearchScreen(),
      ),
    ),
  );

  group('Mobile Search Screen', () {
    testWidgets('Should render widget [Search Box]', (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      expect(find.byType(SearchBox), findsOneWidget);
    });
  });
  group('Tablet Search Screen', () {
    testWidgets('Should render widget [Search Box]', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(SearchBox), findsOneWidget);
    });
  });
}

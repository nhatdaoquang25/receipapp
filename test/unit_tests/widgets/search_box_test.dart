import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/recipe/recipe_bloc.dart';
import 'package:mobile_app/src/blocs/recipe/recipe_state.dart';
import 'package:mobile_app/src/models/recipe_model.dart';
import 'package:mobile_app/src/services/search_service.dart';
import 'package:mobile_app/src/widgets/search_box.dart';
import 'package:mocktail/mocktail.dart';

class MockRecipeService extends Mock implements RecipeService {}

main() async {
  final List<RecipeModel> responseList = [
    RecipeModel(id: 'id', label: 'chicken valous'),
    RecipeModel(id: 'id', label: 'baked chicken'),
  ];
  final mockSearchServices = MockRecipeService();
  final recipeBloc = RecipeBloc(recipeService: mockSearchServices);
  final widget = MaterialApp(
    home: Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: recipeBloc),
        ],
        child: SearchBox(),
      ),
    ),
  );

  group('Mobile Search Box', () {
    testWidgets(
        'Should render [Seach Box] with icon search , icon filter and hint text',
        (tester) async {
      final AssetImage imageIconFilter = AssetImage(
        'assets/icons/filter_icon.png',
      );
      tester.binding.window.physicalSizeTestValue = Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      final imageFinder = tester.widgetList<Image>(find.byType(Image)).toList();
      expect(imageFinder[0].image, imageIconFilter);
      expect(find.text('Search recipe, people, or tag'), findsOneWidget);
    });

    testWidgets(
        'Should render [Circular Progress Indicator] when state is [RecipeSearchLoading] after that state is [RecipeSearchFailure] when got limit api searching]',
        (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      recipeBloc.emit(RecipeSearchLoading());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      recipeBloc.emit(RecipeSearchFailure(
          failMessage: 'Oops! Look like something wrong here'));
      await tester.pump();
      expect(find.text('Oops! Look like something wrong here'), findsOneWidget);
    });
    testWidgets(
        'Should render [Autocomplete Text] when fill text in TextField and exists [HightlightKeyword] widget',
        (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 1));
      await tester.enterText(find.byType(TextField).first, 'ch');
      recipeBloc.emit(RecipeSearchSuccess(recipeTextFieldValue: responseList));
      await tester.pump(Duration(seconds: 1));
      expect(find.byType(HightlightKeyword).first, findsOneWidget);
      expect(find.text('chicken valous'), findsOneWidget);
    });
  });

  group('Tablet Search Box', () {
    testWidgets(
        'Should render search box with icon search , hint text , icon notification, icon mail and circle avatar',
        (tester) async {
      final AssetImage filterIcon = AssetImage(
        'assets/icons/filter_icon.png',
      );
      final AssetImage notificationIcon = AssetImage(
        'assets/icons/notification_icon.png',
      );
      final AssetImage mailIcon = AssetImage(
        'assets/icons/email_icon.png',
      );
      await tester.pumpWidget(widget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(
          find.text('Search Recipe, Profile, or Ingredients'), findsOneWidget);
      final imageFinder = tester.widgetList<Image>(find.byType(Image)).toList();
      expect(imageFinder[0].image, filterIcon);
      expect(imageFinder[1].image, notificationIcon);
      expect(imageFinder[2].image, mailIcon);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
    testWidgets(
        'Should render [Circular Progress Indicator] when state is [RecipeSearchLoading] after that state is [RecipeSearchFailure] when got limit api searching]',
        (tester) async {
      await tester.pumpWidget(widget);
      recipeBloc.emit(RecipeSearchLoading());
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      recipeBloc.emit(RecipeSearchFailure(
          failMessage: 'Oops! Look like something wrong here'));
      await tester.pump();
      expect(find.text('Oops! Look like something wrong here'), findsOneWidget);
    });
  });
}

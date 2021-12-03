import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/recipe/recipe_bloc.dart';
import 'package:mobile_app/src/blocs/recipe/recipe_event.dart';
import 'package:mobile_app/src/blocs/recipe/recipe_state.dart';
import 'package:mobile_app/src/models/recipe_model.dart';
import 'package:mobile_app/src/services/search_service.dart';

import '../../mock/mock_recipe_service.dart';

void main() async {
  final List<RecipeModel> responseList = [
    RecipeModel(id: 'id', label: 'chicken valous'),
    RecipeModel(id: 'id', label: 'baked chicken')
  ];
  late RecipeService recipeService;
  late RecipeBloc recipeBloc;
  setUp(() {
    recipeService = MockRecipeService(responseList);
    recipeBloc = RecipeBloc(recipeService: recipeService);
  });
  tearDown(() {
    recipeBloc.close();
  });

  blocTest('emits [] when no event is added',
      build: () => RecipeBloc(recipeService: recipeService), expect: () => []);
  blocTest(
    'emits [RecipeSearchLoading] then [RecipeSearchFailure] when [RecipeTextFieldChanged] is called',
    build: () {
      recipeService = MockRecipeService(responseList);
      return RecipeBloc(recipeService: recipeService);
    },
    act: (RecipeBloc bloc) => bloc.add(RecipeTextFieldChanged('c')),
    expect: () => [
      RecipeSearchLoading(),
      RecipeSearchFailure(failMessage: 'Oops! Look like something wrong here'),
    ],
  );
  blocTest(
    'emits [RecipeSearchLoading] then [RecipeSearchSuccess] when [RecipeTextFieldChanged] is called with valid data.',
    build: () {
      recipeService = MockRecipeService(responseList);
      return RecipeBloc(recipeService: recipeService);
    },
    act: (RecipeBloc bloc) => bloc.add(RecipeTextFieldChanged('ch')),
    expect: () => [
      RecipeSearchLoading(),
      RecipeSearchSuccess(recipeTextFieldValue: responseList),
    ],
  );
  blocTest(
    'emits [RecipeSearchTextFieldEmptyChangedSuccess] and [RecipeInitial]  when [RecipeTextFieldChanged] is called with data empty.',
    build: () {
      recipeService = MockRecipeService(responseList);
      return RecipeBloc(recipeService: recipeService);
    },
    act: (RecipeBloc bloc) => bloc.add(RecipeTextFieldChanged('')),
    expect: () => [
      RecipeSearchTextFieldEmptyChangedSuccess(),
      RecipeInitial(),
    ],
  );
  blocTest(
    'emits [RecipeSelectedSuccess] when [RecipeSearchSelected] is called with selected data.',
    build: () {
      recipeService = MockRecipeService(responseList);
      return RecipeBloc(recipeService: recipeService);
    },
    act: (RecipeBloc bloc) =>
        bloc.add(RecipeSearchSelected('recipe name', 'url')),
    expect: () => [
      RecipeSelectedSuccess('recipe name'),
    ],
  );
}

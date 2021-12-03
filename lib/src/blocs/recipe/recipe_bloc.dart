import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../constants/constants_text.dart';
import '../../models/recipe_model.dart';
import '../../services/search_service.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeService recipeService;

  RecipeBloc({required this.recipeService}) : super(RecipeInitial());

  @override
  Stream<RecipeState> mapEventToState(
    RecipeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case RecipeTextFieldChanged:
        event as RecipeTextFieldChanged;
        if (event.searchText.isNotEmpty) {
          yield RecipeSearchLoading();
          try {
            List<RecipeModel>? recipes =
                await recipeService.getRecipes(event.searchText);
            if (recipes.isNotEmpty) {
              yield RecipeSearchSuccess(recipeTextFieldValue: recipes);
            } else {
              yield RecipeSearchFailure(failMessage: SearchText.searchNotFound);
            }
          } catch (e) {
              yield RecipeSearchFailure(failMessage: SearchText.limitSearchApi);
          }
        } else {
          yield RecipeSearchTextFieldEmptyChangedSuccess();
          await Future.delayed(Duration(seconds: 1));
          yield RecipeInitial();
        }
        break;
      case RecipeSearchSelected:
        event as RecipeSearchSelected;
        if (event.selectedRecipe.isNotEmpty && event.urlRecipe.isNotEmpty) {
          yield RecipeSelectedSuccess(event.selectedRecipe);
        } else {
         yield RecipeSelectedFailure();
        }
        break;
      default:
    }
  }
}

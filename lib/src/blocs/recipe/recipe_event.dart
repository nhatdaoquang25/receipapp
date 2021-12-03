import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeTextFieldChanged extends RecipeEvent {
  final String searchText;
  RecipeTextFieldChanged(this.searchText);
  @override
  List<Object> get props => [searchText];
}

class RecipeSearchSelected extends RecipeEvent {
  final String selectedRecipe;
  final String urlRecipe;

  RecipeSearchSelected(this.selectedRecipe, this.urlRecipe);
  @override
  List<Object> get props => [selectedRecipe, urlRecipe];
}

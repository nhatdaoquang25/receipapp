import 'package:equatable/equatable.dart';

import '../../models/recipe_model.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();
  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeSearchSuccess extends RecipeState {
  final List<RecipeModel> recipeTextFieldValue;
  const RecipeSearchSuccess({required this.recipeTextFieldValue});
  @override
  List<Object> get props => [recipeTextFieldValue];
}

class RecipeSearchTextFieldEmptyChangedSuccess extends RecipeState {}

class RecipeSearchFailure extends RecipeState {
  final String failMessage;
  const RecipeSearchFailure({required this.failMessage});
  @override
  List<Object> get props => [failMessage];
}

class RecipeSearchLoading extends RecipeState {}

class RecipeSelectedSuccess extends RecipeState {
  final String recipeName;
  const RecipeSelectedSuccess(this.recipeName);
  @override
  List<Object> get props => [recipeName];
}

class RecipeSelectedFailure extends RecipeState {}

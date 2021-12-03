import 'dart:io';
import 'package:equatable/equatable.dart';

import '../../models/create_recipe_model.dart';

abstract class CreateRecipeState extends Equatable {
  const CreateRecipeState();

  @override
  List<Object> get props => [];
}

class CreateRecipeInitial extends CreateRecipeState {}

class CreateRecipeImagePickSuccess extends CreateRecipeState {
  final File recipeImage;
  CreateRecipeImagePickSuccess({required this.recipeImage});

  @override
  List<Object> get props => [recipeImage];
}

class CreateRecipeGalleryImagePickSuccess extends CreateRecipeState {
  final List<File> galleryImage;
  CreateRecipeGalleryImagePickSuccess({required this.galleryImage});

  @override
  List<Object> get props => [galleryImage];
}

class CreateRecipeIngredientImagePickSuccess extends CreateRecipeState {
  final File ingredientImage;
  CreateRecipeIngredientImagePickSuccess({required this.ingredientImage});

  @override
  List<Object> get props => [ingredientImage];
}

class CreateRecipeIngredientAddSuccess extends CreateRecipeState {
  final List<IngredientModel> ingredientList;
  CreateRecipeIngredientAddSuccess({required this.ingredientList});

  @override
  List<Object> get props => [ingredientList];
}

class CreateRecipeDirectionAddSuccess extends CreateRecipeState {
  final List<String> directionList;
  CreateRecipeDirectionAddSuccess({required this.directionList});

  @override
  List<Object> get props => [directionList];
}

class CreateRecipeTimeInfoAddSuccess extends CreateRecipeState {
  final String time;
  CreateRecipeTimeInfoAddSuccess({required this.time});

  @override
  List<Object> get props => [time];
}

class CreateRecipeNutritionInfoAddSuccess extends CreateRecipeState {
  final String nutrition;
  CreateRecipeNutritionInfoAddSuccess({required this.nutrition});

  @override
  List<Object> get props => [nutrition];
}

class CreateRecipeTagInfoAddSuccess extends CreateRecipeState {
  final String tag;
  CreateRecipeTagInfoAddSuccess({required this.tag});

  @override
  List<Object> get props => [tag];
}

class CreateRecipeSaveSuccess extends CreateRecipeState {
  final bool saveSuccess;
  CreateRecipeSaveSuccess({required this.saveSuccess});

  @override
  List<Object> get props => [saveSuccess];
}

class CreateRecipeFailure extends CreateRecipeState {
  final String errorMessage;
  CreateRecipeFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

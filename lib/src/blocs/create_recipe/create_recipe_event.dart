import 'dart:io';
import 'package:equatable/equatable.dart';

import '../../models/create_recipe_model.dart';

abstract class CreateRecipeEvent extends Equatable {
  const CreateRecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeImagePicked extends CreateRecipeEvent {
  @override
  List<Object> get props => [];
}

class CreateRecipeImageCameraPicked extends CreateRecipeEvent {}

class CreateRecipeGalleryImagePicked extends CreateRecipeEvent {}

class CreateRecipeGalleryImageCameraPicked extends CreateRecipeEvent {}

class CreateRecipeIngredientImagePicked extends CreateRecipeEvent {}

class CreateRecipeIngredientAdded extends CreateRecipeEvent {
  final String ingredientText;
  final File ingredientImage;
  CreateRecipeIngredientAdded(
      {required this.ingredientText, required this.ingredientImage});

  @override
  List<Object> get props => [ingredientText, ingredientImage];
}

class CreateRecipeDirectionAdded extends CreateRecipeEvent {
  final String direction;
  CreateRecipeDirectionAdded({required this.direction});

  @override
  List<Object> get props => [direction];
}

class CreateRecipeTimeInfoAdded extends CreateRecipeEvent {
  final String time;
  CreateRecipeTimeInfoAdded({required this.time});

  @override
  List<Object> get props => [time];
}

class CreateRecipeNutritionInfoAdded extends CreateRecipeEvent {
  final String nutrition;
  CreateRecipeNutritionInfoAdded({required this.nutrition});

  @override
  List<Object> get props => [nutrition];
}

class CreateRecipeTagInfoAdded extends CreateRecipeEvent {
  final String tag;
  CreateRecipeTagInfoAdded({required this.tag});

  @override
  List<Object> get props => [tag];
}

class CreateRecipeSaved extends CreateRecipeEvent {
  final String recipeName;
  final File recipeImage;
  final List<File> galleryImage;
  final List<IngredientModel> ingredientList;
  final List<String> durationList;
  final String servingTime;
  final String nutrition;
  final String tag;
  CreateRecipeSaved(
      {required this.recipeName,
      required this.recipeImage,
      required this.galleryImage,
      required this.ingredientList,
      required this.durationList,
      required this.servingTime,
      required this.nutrition,
      required this.tag});

  @override
  List<Object> get props => [
        recipeName,
        recipeImage,
        galleryImage,
        ingredientList,
        durationList,
        servingTime,
        nutrition,
        tag
      ];
}

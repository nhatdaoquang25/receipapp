import 'dart:io';
import 'package:bloc/bloc.dart';

import 'create_recipe_event.dart';
import 'create_recipe_state.dart';
import '../../models/create_recipe_model.dart';
import '../../services/create_recipe_service.dart';
import '../../constants/constants_text.dart';

class CreateRecipeBloc extends Bloc<CreateRecipeEvent, CreateRecipeState> {
  final CreateRecipeService? createRecipeService;
  CreateRecipeBloc({this.createRecipeService}) : super(CreateRecipeInitial());

  File recipeImage = File('');
  List<File> galleryImage = [];
  List<File> listGalleryImage = [];
  File ingredientImagePicked = File('');
  List<IngredientModel> ingredientList = [];
  List<String> directionList = [];
  String time = '';
  String nutrition = '';
  String tag = '';
  bool saveSuccess = false;

  @override
  Stream<CreateRecipeState> mapEventToState(
    CreateRecipeEvent event,
  ) async* {
    switch (event.runtimeType) {
      case RecipeImagePicked:
        recipeImage = await createRecipeService!.pickRecipeImage();
        yield CreateRecipeImagePickSuccess(recipeImage: recipeImage);
        break;
      case CreateRecipeImageCameraPicked:
        yield CreateRecipeImagePickSuccess(recipeImage: recipeImage);
        break;
      case CreateRecipeGalleryImagePicked:
        listGalleryImage = await createRecipeService!.pickGalleryImage();
        yield CreateRecipeGalleryImagePickSuccess(
            galleryImage: listGalleryImage);
        break;
      case CreateRecipeIngredientImagePicked:
        ingredientImagePicked = await createRecipeService!.pickIngredientImage();
        yield CreateRecipeIngredientImagePickSuccess(
            ingredientImage: ingredientImagePicked);
        break;
      case CreateRecipeIngredientAdded:
        event as CreateRecipeIngredientAdded;
        final ingredient = IngredientModel(
            ingredientText: event.ingredientText,
            ingredientImage: event.ingredientImage);
        ingredientList.add(ingredient);
        yield CreateRecipeIngredientAddSuccess(ingredientList: ingredientList);
        break;
      case CreateRecipeDirectionAdded:
        event as CreateRecipeDirectionAdded;
        String direction = event.direction;
        directionList.add(direction);
        yield CreateRecipeDirectionAddSuccess(directionList: directionList);
        break;
      case CreateRecipeTimeInfoAdded:
        event as CreateRecipeTimeInfoAdded;
        time = event.time;
        yield CreateRecipeTimeInfoAddSuccess(time: time);
        break;
      case CreateRecipeNutritionInfoAdded:
        event as CreateRecipeNutritionInfoAdded;
        nutrition = event.nutrition;
        yield CreateRecipeNutritionInfoAddSuccess(nutrition: nutrition);
        break;
      case CreateRecipeTagInfoAdded:
        event as CreateRecipeTagInfoAdded;
        tag = event.tag;
        yield CreateRecipeTagInfoAddSuccess(tag: tag);
        break;
      case CreateRecipeSaved:
        event as CreateRecipeSaved;
        final String recipeImage =
            await createRecipeService!.upLoadRecipeImage(event.recipeImage);
        final List<String> galleryImage =
            await createRecipeService!.upLoadGalleryImage(event.galleryImage);
        final List<IngredientModel> ingredientList =
            await createRecipeService!.uploadIngredientImage(event.ingredientList);
        createRecipeService!.createRecipe(
            event.recipeName,
            recipeImage,
            galleryImage,
            ingredientList,
            event.durationList,
            event.servingTime,
            nutrition,
            event.tag);
        yield CreateRecipeSaveSuccess(saveSuccess: !saveSuccess);
        break;
      default:
        yield CreateRecipeFailure(errorMessage: CreateRecipeText.errorMessage);
        break;
    }
  }
}

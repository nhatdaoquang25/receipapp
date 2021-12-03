import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_bloc.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_event.dart';
import 'package:mobile_app/src/blocs/create_recipe/create_recipe_state.dart';
import 'package:mobile_app/src/models/create_recipe_model.dart';
import 'package:mobile_app/src/services/create_recipe_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';

class MockCreateRecipeEvent extends CreateRecipeEvent {}

class MockDataService extends Mock implements CreateRecipeService {
  @override
  Future<File> pickRecipeImage() async {
    File recipeImage = File('/assets/images/backgroundloading.png');
    return recipeImage;
  }

  @override
  Future<File> pickRecipeCameraImage() async {
    File recipeImage = File('/assets/images/backgroundloading.png');
    return recipeImage;
  }

  @override
  Future<List<File>> pickGalleryImage() async {
    List<File> galleryImage = [File('/assets/images/backgroundloading.png')];
    return galleryImage;
  }

  @override
  Future<List<File>> pickGalleryCameraImage() async {
    List<File> galleryImage = [File('/assets/images/backgroundloading.png')];
    return galleryImage;
  }

  @override
  Future<File> pickIngredientImage() async {
    File ingredientImagePicked = File('/assets/images/backgroundloading.png');
    return ingredientImagePicked;
  }

  @override
  Future<String> upLoadRecipeImage(File file) async {
    if (file == File('/assets/images/backgroundloading.png')) {
      String recipeImage = '/assets/images/backgroundloading.png';
      return recipeImage;
    } else {
      return '';
    }
  }

  @override
  Future<List<String>> upLoadGalleryImage(List<File> images) async {
    List<String> galleryImage = [];
    if (images == [File('/assets/images/backgroundloading.png')]) {
      String imageUrl = '/assets/images/backgroundloading.png';
      galleryImage.add(imageUrl);
      return galleryImage;
    } else {
      return [];
    }
  }

  @override
  Future<List<IngredientModel>> uploadIngredientImage(
      List<IngredientModel> ingredientList) async {
    List<IngredientModel> newIngredientList = [];
    if (ingredientList ==
        [
          IngredientModel(
            ingredientText: 'qua chanh',
            ingredientImage: File('/assets/images/backgroundloading.png'),
          )
        ]) {
      var newIngredient = IngredientModel(
          ingredientText: 'qua chanh',
          ingredientImage: '/assets/images/backgroundloading.png');
      newIngredientList.add(newIngredient);
      return newIngredientList;
    } else {
      return [];
    }
  }

  @override
  Future<void> createRecipe(
      String recipeName,
      String recipeImage,
      List<String> galleryImage,
      List<IngredientModel> ingredientList,
      List<String> durationList,
      String servingTime,
      String nutrition,
      String tag) async {
    CreateRecipeSaveSuccess(saveSuccess: true);
  }
}

void main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();

  CreateRecipeService createRecipeService;
  CreateRecipeBloc? createRecipeBloc;
  setUp(() {
    createRecipeService = MockDataService();
    createRecipeBloc = CreateRecipeBloc(createRecipeService: createRecipeService);
  });
  tearDown(() {
    createRecipeBloc?.close();
  });

  blocTest('emit [] when no event is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      expect: () => []);

  blocTest(
      'emit [CreateRecipeImagePickSuccess] when [RecipeImagePicked] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) => bloc.add(RecipeImagePicked()),
      expect: () => [isA<CreateRecipeImagePickSuccess>()]);

  blocTest(
      'emit [CreateRecipeImagePickSuccess] when [CreateRecipeImageCameraPicked] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) => bloc.add(CreateRecipeImageCameraPicked()),
      expect: () => [isA<CreateRecipeImagePickSuccess>()]);

  blocTest(
      'emait [CreateRecipeGalleryImagePickSuccess] when [CreateRecipeGalleryImagePicked] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) =>
          bloc.add(CreateRecipeGalleryImagePicked()),
      expect: () => [isA<CreateRecipeGalleryImagePickSuccess>()]);

  blocTest(
      'emit [CreateRecipeGalleryImagePickSuccess] when [CreateRecipeGalleryImageCameraPicked] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) =>
          bloc.add(CreateRecipeGalleryImageCameraPicked()),
      expect: () => [isA<CreateRecipeGalleryImagePickSuccess>()]);

  blocTest(
      'emit [CreateRecipeIngredientImagePickSuccess] when [CreateRecipeIngredientImagePicked] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) =>
          bloc.add(CreateRecipeIngredientImagePicked()),
      expect: () => [isA<CreateRecipeIngredientImagePickSuccess>()]);

  blocTest(
      'emit [CreateRecipeIngredientAddSuccess] when [CreateRecipeIngredientAdded] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) => bloc.add(CreateRecipeIngredientAdded(
          ingredientText: 'qua chanh',
          ingredientImage: File('/assets/images/backgroundloading.png'))),
      expect: () => [isA<CreateRecipeIngredientAddSuccess>()]);

  blocTest(
      'emit [CreateRecipeDirectionAddSuccess] when [CreateRecipeDirectionAdded] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) =>
          bloc.add(CreateRecipeDirectionAdded(direction: 'qua chanh')),
      expect: () => [
            CreateRecipeDirectionAddSuccess(directionList: ['qua chanh'])
          ]);

  blocTest(
      'emit [CreateRecipeTimeInfoAddSuccess] when [CreateRecipeTimeInfoAdded] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) =>
          bloc.add(CreateRecipeTimeInfoAdded(time: '30 mins')),
      expect: () => [CreateRecipeTimeInfoAddSuccess(time: '30 mins')]);

  blocTest(
      'emit [CreateRecipeNutritionInfoAddSuccess] when [CreateRecipeNutritionInfoAdded] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) =>
          bloc.add(CreateRecipeNutritionInfoAdded(nutrition: '30g calo')),
      expect: () =>
          [CreateRecipeNutritionInfoAddSuccess(nutrition: '30g calo')]);

  blocTest(
      'emit [CreateRecipeTagInfoAddSuccess] when [CreateRecipeTagInfoAdded] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) =>
          bloc.add(CreateRecipeTagInfoAdded(tag: 'thucannhanh')),
      expect: () => [CreateRecipeTagInfoAddSuccess(tag: 'thucannhanh')]);

  blocTest('emit [CreateRecipeSaveSuccess] when [CreateRecipeSaved] is added',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) => bloc.add(CreateRecipeSaved(
          recipeName: 'Nuoc Chanh',
          recipeImage: File('/assets/images/backgroundloading.png'),
          galleryImage: [File('/assets/images/backgroundloading.png')],
          ingredientList: [
            IngredientModel(
                ingredientText: 'qua chanh',
                ingredientImage: File('/assets/images/backgroundloading.png'))
          ],
          durationList: ['qua chanh'],
          servingTime: '30 mins',
          nutrition: 'calo',
          tag: 'nuocchanh')),
      expect: () => [
            CreateRecipeSaveSuccess(saveSuccess: true),
          ]);

  blocTest('emit [RecipeCreateFailure] when invalid event is called',
      build: () {
        createRecipeService = MockDataService();
        return CreateRecipeBloc(createRecipeService: createRecipeService);
      },
      act: (CreateRecipeBloc bloc) => bloc.add(MockCreateRecipeEvent()),
      expect: () => [
            CreateRecipeFailure(errorMessage: 'error'),
          ]);
}

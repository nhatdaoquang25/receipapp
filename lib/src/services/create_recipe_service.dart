import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/create_recipe_model.dart';

class CreateRecipeService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference recipeCollection =
      FirebaseFirestore.instance.collection('recipe');

  Future<File> pickRecipeImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final File recipeImage = File(image!.path);
    return recipeImage;
  }

  Future<File> pickRecipeCameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    final File recipeImage = File(image!.path);
    return recipeImage;
  }

  Future<List<File>> pickGalleryImage() async {
    List<File> galleryImage = [];
    List<File> listGalleryImage = [];
    final List<XFile?>? images = await ImagePicker().pickMultiImage();
    images?.map((e) => galleryImage.add(File(e!.path))).toList();
    listGalleryImage.addAll(galleryImage);
    galleryImage.clear();
    return listGalleryImage;
  }

  Future<List<File>> pickGalleryCameraImage() async {
    List<File> listGalleryImage = [];
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    listGalleryImage.add(File(image!.path));
    return listGalleryImage;
  }

  Future<File> pickIngredientImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final File ingredientImagePicked = File(image!.path);
    return ingredientImagePicked;
  }

  Future<String> upLoadRecipeImage(File file) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref("background/")
          .child('${file.path.split('/').last}');
      UploadTask uploadTask = ref.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String image = await taskSnapshot.ref.getDownloadURL();
      return image;
    } catch (e) {
      return "";
    }
  }

  Future<List<String>> upLoadGalleryImage(List<File> images) async {
    if (images.length < 1) return [];
    List<String> galleryImage = [];
    await Future.forEach(images, (File image) async {
      Reference ref = FirebaseStorage.instance
          .ref("gallerys/")
          .child('${image.path.split('/').last}');
      UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await taskSnapshot.ref.getDownloadURL();
      galleryImage.add(imageUrl);
    });
    return galleryImage;
  }

  Future<List<IngredientModel>> uploadIngredientImage(
      List<IngredientModel> ingredientList) async {
    List<IngredientModel> newIngredientList = [];
    await Future.forEach(ingredientList, (IngredientModel ingredient) async {
      if (ingredient.ingredientImage.path == "") {
        var newIngredient = IngredientModel(
            ingredientText: ingredient.ingredientText, ingredientImage: "");
        newIngredientList.add(newIngredient);
      } else {
        Reference ref = FirebaseStorage.instance
            .ref("ingredient/")
            .child('${ingredient.ingredientImage.path.split('/').last}');
        UploadTask uploadTask = ref.putFile(ingredient.ingredientImage);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        final ingredientImage = await taskSnapshot.ref.getDownloadURL();
        var newIngredient = IngredientModel(
            ingredientText: ingredient.ingredientText,
            ingredientImage: ingredientImage);
        newIngredientList.add(newIngredient);
      }
    });
    print(newIngredientList);
    return newIngredientList;
  }

  Future<void> createRecipe(
      String recipeName,
      String recipeImage,
      List<String> galleryImage,
      List<IngredientModel> ingredientList,
      List<String> durationList,
      String servingTime,
      String nutrition,
      String tag) async {
    User? user = auth.currentUser;
    return recipeCollection.doc().set({
      'author': user?.email,
      'recipeName': recipeName,
      'recipeImage': recipeImage,
      'galleryImage': galleryImage,
      'ingredient': ingredientList.map((e) => e.toJson()).toList(),
      'cookRecipe': durationList,
      'additionalInfo': {
        'time': servingTime,
        'nutrition': nutrition,
        'tag': tag,
      }
    });
  }
}

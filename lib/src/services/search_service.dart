import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/recipe_model.dart';

final recipeURL = (recipeName) =>
    'https://api.edamam.com/api/recipes/v2?type=public&q=$recipeName&app_id=c08410f3&app_key=4f3f373fef60e01afe71692aa7d0074b';

class RecipeService {
  Future<List<RecipeModel>> getRecipes(String recipeName) async {
    var response = await http.get(Uri.parse(recipeURL(recipeName)));
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);
      var responseList = Map<String, dynamic>.from(decodeData)['hits'];
      return responseList
          .map<RecipeModel>((json) => RecipeModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load recipes list');
    }
  }
}

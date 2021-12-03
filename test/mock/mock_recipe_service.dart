import 'package:mobile_app/src/models/recipe_model.dart';
import 'package:mobile_app/src/services/search_service.dart';
import 'package:mocktail/mocktail.dart';

class MockRecipeService extends Mock implements RecipeService {
  final List<RecipeModel> responseList;

  MockRecipeService(this.responseList);
  @override
  Future<List<RecipeModel>> getRecipes(String query) async {
    if (query == 'ch') {
      return responseList;
    } else {
      throw Exception('Failed to load recipes list');
    }
  }
}

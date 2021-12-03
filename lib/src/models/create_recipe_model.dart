class IngredientModel {
  const IngredientModel(
      {required this.ingredientText, required this.ingredientImage});
  final String ingredientText;
  final dynamic ingredientImage;
  Map<String, dynamic> toJson() =>
      {'ingredientText': ingredientText, 'ingredientImage': ingredientImage};
}

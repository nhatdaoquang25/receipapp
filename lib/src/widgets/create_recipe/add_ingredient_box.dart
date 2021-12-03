import 'package:flutter/material.dart';

import '../responsive.dart';
import '../../constants/constants_text.dart';
import '../../models/create_recipe_model.dart';
import '../../constants/constants_color.dart';

class AddIngredient extends StatefulWidget {
  const AddIngredient({Key? key, required this.ingredientList})
      : super(key: key);

  final List<IngredientModel> ingredientList;

  @override
  _AddIngredientState createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double widthAddBox = widthScreen * 295 / 375;
    double hightAddBox = heightScreen * 50 / 812;
    double widthField = widthScreen * 202 / 375;
    double widthInteredientImage = 50;
    double heightInteredientImage = 35;
    double ingredientBoxAndBottomSpacing = heightScreen * 15 / 812;
    if (Responsive.isTablet(context)) {
      widthAddBox = widthScreen * 501 / 768;
      hightAddBox = heightScreen * 50 / 1024;
      widthField = widthScreen * 380 / 768;
      widthInteredientImage = 70;
      heightInteredientImage = 50;
      ingredientBoxAndBottomSpacing = heightScreen * 15 / 1024;
    }
    return Column(
      children: widget.ingredientList
          .map(
            (ingredient) => Container(
              width: widthAddBox,
              height: hightAddBox,
              margin: EdgeInsets.only(bottom: ingredientBoxAndBottomSpacing),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1, color: CreateRecipeColor.boxBorderColor),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Image(
                      image: AssetImage('assets/icons/add_icon.png'),
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Container(
                      width: widthField,
                      height: hightAddBox,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ingredient.ingredientText,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontFamily: AppConstants.fontRegular,
                            height: 1.375,
                            color: CreateRecipeColor.mainTextColor
                                .withOpacity(0.5)),
                      )),
                  Container(
                      width: widthInteredientImage,
                      height: heightInteredientImage,
                      child: ingredient.ingredientImage.path == ""
                          ? Image(
                              image:
                                  AssetImage('assets/icons/image_add_icon.png'),
                              width: 20,
                              height: 20,
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                              child: Image.file(
                                ingredient.ingredientImage,
                                fit: BoxFit.cover,
                              ),
                            )),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';

import '../responsive.dart';
import '../../constants/constants_text.dart';
import '../../constants/constants_color.dart';

class AddCookRecipeBox extends StatefulWidget {
  const AddCookRecipeBox({Key? key, required this.cookRecipeList})
      : super(key: key);

  final List<String> cookRecipeList;

  @override
  _AddCookRecipeBoxState createState() => _AddCookRecipeBoxState();
}

class _AddCookRecipeBoxState extends State<AddCookRecipeBox> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double widthAddBox = widthScreen * 295 / 375;
    double hightAddBox = heightScreen * 50 / 812;
    double widthField = widthScreen * 245 / 375;
    double directionBoxAndBottomSpacing = heightScreen * 15 / 812;
    if (Responsive.isTablet(context)) {
      widthAddBox = widthScreen * 501 / 768;
      hightAddBox = heightScreen * 50 / 1024;
      widthField = widthScreen * 450 / 768;
      directionBoxAndBottomSpacing = heightScreen * 15 / 1024;
    }
    return Column(
      children: widget.cookRecipeList
          .map(
            (cookRecipe) => Container(
              width: widthAddBox,
              height: hightAddBox,
              margin: EdgeInsets.only(bottom: directionBoxAndBottomSpacing),
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
                        cookRecipe,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontFamily: AppConstants.fontRegular,
                            height: 1.375,
                            color: CreateRecipeColor.mainTextColor
                                .withOpacity(0.5)),
                      ))
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../responsive.dart';
import '../../constants/constants_text.dart';
import '../../constants/constants_color.dart';
import '../../blocs/create_recipe/create_recipe_bloc.dart';
import '../../blocs/create_recipe/create_recipe_event.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({Key? key}) : super(key: key);

  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double addInfoBoxAndTopSpacing = heightScreen * 15 / 812;
    double widthAddBox = widthScreen * 295 / 375;
    double servingTimePadding = widthScreen * 39 / 375;
    double nutritionPadding = widthScreen * 30 / 375;
    double tagPadding = widthScreen * 85 / 375;
    double heightText = 1.57;
    if (Responsive.isTablet(context)) {
      heightScreen = MediaQuery.of(context).size.height;
      widthScreen = MediaQuery.of(context).size.width;
      widthAddBox = widthScreen * 501 / 768;
      servingTimePadding = widthScreen * 39 / 768;
      nutritionPadding = widthScreen * 30 / 768;
      tagPadding = widthScreen * 92 / 768;
      heightText = 1.57;
    }
    return Column(
      children: [
        SizedBox(height: addInfoBoxAndTopSpacing),
        Container(
          width: widthAddBox,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(width: 1, color: CreateRecipeColor.boxBorderColor),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      CreateRecipeText.time,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontFamily: AppConstants.fontRegular,
                          height: heightText,
                          color: CreateRecipeColor.textColor),
                    ),
                    SizedBox(width: servingTimePadding),
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (time) {
                          BlocProvider.of<CreateRecipeBloc>(context)
                              .add(CreateRecipeTimeInfoAdded(time: time));
                        },
                        cursorColor: CreateRecipeColor.cursorColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      CreateRecipeText.nutrition,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontFamily: AppConstants.fontRegular,
                          height: heightText,
                          color: CreateRecipeColor.textColor),
                    ),
                    SizedBox(width: nutritionPadding),
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (nutrition) {
                          BlocProvider.of<CreateRecipeBloc>(context).add(
                              CreateRecipeNutritionInfoAdded(
                                  nutrition: nutrition));
                        },
                        cursorColor: CreateRecipeColor.cursorColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      CreateRecipeText.tags,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontFamily: AppConstants.fontRegular,
                          height: 1.57,
                          color: CreateRecipeColor.textColor),
                    ),
                    SizedBox(width: tagPadding),
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (tag) {
                          BlocProvider.of<CreateRecipeBloc>(context)
                              .add(CreateRecipeTagInfoAdded(tag: tag));
                        },
                        cursorColor: CreateRecipeColor.cursorColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

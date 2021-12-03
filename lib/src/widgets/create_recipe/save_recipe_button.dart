import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/create_recipe/create_recipe_bloc.dart';
import '../../blocs/create_recipe/create_recipe_event.dart';
import '../../blocs/create_recipe/create_recipe_state.dart';
import '../../constants/constants_color.dart';
import '../../constants/constants_text.dart';
import '../../models/create_recipe_model.dart';
import '../../services/create_recipe_service.dart';
import '../../widgets/responsive.dart';

class SaveRecipeButton extends StatefulWidget {
  const SaveRecipeButton({
    Key? key,
    required this.durationList,
    required this.recipeName,
    required this.galleryImage,
    required this.ingredientList,
    required this.recipeImage,
    required this.servingTime,
    required this.nutrition,
    required this.tag,
  }) : super(key: key);

  final List<String> durationList;
  final String recipeName;
  final List<File> galleryImage;
  final List<IngredientModel> ingredientList;
  final File recipeImage;
  final String servingTime;
  final String nutrition;
  final String tag;

  @override
  _SaveRecipeButtonState createState() => _SaveRecipeButtonState();
}

class _SaveRecipeButtonState extends State<SaveRecipeButton> {
  String dropdownvalue = 'Western (1)';
  List<String> dataDropDown = [
    'Western (1)',
    'Western (2)',
    'Western (3)',
    'Western (4)',
    'Western (5)'
  ];

  final CreateRecipeService databaseService = CreateRecipeService();

  void saveRecipe(context, state) {
    if (state is CreateRecipeSaveSuccess) {
      if (state.saveSuccess) {
        Future.delayed(Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(CreateRecipeText.saveRecipeSuccessful),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double widthDropDownButton = widthScreen * 190 / 375;
    double heightDropDownButton = heightScreen * 50 / 812;
    double horizontalPadding = widthScreen * 15 / 375;
    double verticalPadding = heightScreen * 14 / 812;
    double dropDownAndSaveButtonSpacing = widthScreen * 15 / 375;
    double widthSaveButton = widthScreen * 120 / 375;
    double heightSaveButton = heightScreen * 50 / 812;
    double borderRadius = 8;
    double heightText = 1.375;
    if (Responsive.isTablet(context)) {
      heightScreen = MediaQuery.of(context).size.height;
      widthScreen = MediaQuery.of(context).size.width;
      widthDropDownButton = widthScreen * 190 / 768;
      heightDropDownButton = heightScreen * 50 / 1024;
      horizontalPadding = widthScreen * 15 / 768;
      verticalPadding = heightScreen * 14 / 1024;
      dropDownAndSaveButtonSpacing = widthScreen * 15 / 768;
      widthSaveButton = widthScreen * 155 / 768;
      heightSaveButton = heightScreen * 50 / 1024;
      borderRadius = 8;
    }

    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
        builder: (context, state) {
      saveRecipe(context, state);
      return Row(
        children: [
          Container(
            width: widthDropDownButton,
            height: heightDropDownButton,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
                  horizontalPadding, verticalPadding),
              child: DropdownButton<String>(
                value: dropdownvalue,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                isExpanded: true,
                underline: Container(color: Colors.white),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontFamily: AppConstants.fontRegular,
                    height: heightText,
                    color: CreateRecipeColor.mainTextColor),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
                items:
                    dataDropDown.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: dropDownAndSaveButtonSpacing),
          Container(
            width: widthSaveButton,
            height: heightSaveButton,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(borderRadius),
                border:
                    Border.all(color: CreateRecipeColor.cursorColor, width: 2)),
            child: TextButton(
              onPressed: () {
                if (widget.recipeName.isNotEmpty &&
                    widget.durationList.isNotEmpty &&
                    widget.servingTime.isNotEmpty &&
                    widget.nutrition.isNotEmpty &&
                    widget.tag.isNotEmpty &&
                    widget.recipeImage != File("") &&
                    widget.galleryImage.isNotEmpty &&
                    widget.ingredientList.isNotEmpty) {
                  BlocProvider.of<CreateRecipeBloc>(context).add(
                      CreateRecipeSaved(
                          recipeName: widget.recipeName,
                          recipeImage: widget.recipeImage,
                          galleryImage: widget.galleryImage,
                          ingredientList: widget.ingredientList,
                          durationList: widget.durationList,
                          servingTime: widget.servingTime,
                          nutrition: widget.nutrition,
                          tag: widget.tag));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(CreateRecipeText.saveRecipeFailure),
                    ),
                  );
                }
              },
              child: Text(
                CreateRecipeText.saveButton,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontFamily: AppConstants.fontBold,
                    height: heightText,
                    letterSpacing: 0.32,
                    color: CreateRecipeColor.cursorColor),
              ),
            ),
          )
        ],
      );
    });
  }
}

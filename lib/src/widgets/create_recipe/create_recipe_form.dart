import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants_text.dart';
import '../../constants/constants_color.dart';
import '../../widgets/responsive.dart';
import '../../models/create_recipe_model.dart';
import '../../blocs/create_recipe/create_recipe_bloc.dart';
import '../../blocs/create_recipe/create_recipe_event.dart';
import '../../blocs/create_recipe/create_recipe_state.dart';
import 'add_ingredient_box.dart';
import 'add_direction_box.dart';
import 'save_recipe_button.dart';
import 'post_to_feed_button.dart';
import 'add_info.dart';

class CreateRecipeForm extends StatefulWidget {
  const CreateRecipeForm({Key? key}) : super(key: key);

  @override
  _CreateRecipeFormState createState() => _CreateRecipeFormState();
}

class _CreateRecipeFormState extends State<CreateRecipeForm> {
  final directionController = TextEditingController();
  final recipeNameController = TextEditingController();
  final ingredientController = TextEditingController();

  List<String> directionList = [];
  File recipeImage = File("");
  List<File> galleryImage = [];
  File ingredientImage = File("");
  List<IngredientModel> ingredientList = [];
  String time = '';
  String nutrition = '';
  String tag = '';
  bool isAddInfo = false;

  void createRecipe(context, state) {
    if (state is CreateRecipeImagePickSuccess) {
      recipeImage = state.recipeImage;
    } else if (state is CreateRecipeGalleryImagePickSuccess) {
      galleryImage = state.galleryImage;
    } else if (state is CreateRecipeIngredientImagePickSuccess) {
      ingredientImage = state.ingredientImage;
    } else if (state is CreateRecipeIngredientAddSuccess) {
      ingredientList = state.ingredientList;
    } else if (state is CreateRecipeDirectionAddSuccess) {
      directionList = state.directionList;
    } else if (state is CreateRecipeTimeInfoAddSuccess) {
      time = state.time;
    } else if (state is CreateRecipeNutritionInfoAddSuccess) {
      nutrition = state.nutrition;
    } else if (state is CreateRecipeTagInfoAddSuccess) {
      tag = state.tag;
    }
  }

  void showRecipeImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bottomSheetContext) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text(CreateRecipeText.photolibrary),
                    onTap: () {
                      BlocProvider.of<CreateRecipeBloc>(context)
                          .add(RecipeImagePicked());
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text(CreateRecipeText.camera),
                  onTap: () {
                    BlocProvider.of<CreateRecipeBloc>(context)
                        .add(CreateRecipeImageCameraPicked());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void showGalleryImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bottomSheetContext) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text(CreateRecipeText.photolibrary),
                    onTap: () {
                      BlocProvider.of<CreateRecipeBloc>(context)
                          .add(CreateRecipeGalleryImagePicked());
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text(CreateRecipeText.camera),
                  onTap: () {
                    BlocProvider.of<CreateRecipeBloc>(context)
                        .add(CreateRecipeGalleryImageCameraPicked());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double createFormPadding = widthScreen * 25 / 375;
    double widthBox = widthScreen * 325 / 375;
    double widthAddRecipeImage = 62;
    double heightAddRecipeImage = 62;
    double addRecipeImageAndNameSpacing = widthScreen * 15 / 375;
    double heightRecipeNameContainer = 65;
    double widthRecipeNameContainer = widthScreen * 247 / 375;
    double boxAndTopSpacing = heightScreen * 20 / 812;
    double boxContextPadding = widthScreen * 15 / 375;
    double boxContentAndTopSpacing = heightScreen * 15 / 812;
    double widthEditIcon = widthScreen * 24 / 375;
    double heightEditIcon = heightScreen * 24 / 812;
    double editIconAndBottomSpacing = heightScreen * 20 / 812;
    double widthAddBox = widthScreen * 295 / 375;
    double hightAddBox = heightScreen * 50 / 812;
    double saveTextAndFormSpacing = heightScreen * 30 / 812;
    double saveButtonSpacing = heightScreen * 10 / 812;
    double widthField = widthScreen * 235 / 375;
    double saveAndPostButtonSpacing = heightScreen * 30 / 812;
    double boxAndBottomSpacing = heightScreen * 15 / 812;
    double widthIngredientAddIcon = 50;
    double heightIngredientAddIcon = 35;
    double boderRadius = 8;
    double heightText = 1.375;

    if (Responsive.isTablet(context)) {
      heightScreen = MediaQuery.of(context).size.height;
      widthScreen = MediaQuery.of(context).size.width;
      createFormPadding = widthScreen * 119 / 768;
      widthAddRecipeImage = 62;
      heightAddRecipeImage = 62;
      addRecipeImageAndNameSpacing = widthScreen * 15 / 768;
      heightRecipeNameContainer = 65;
      widthRecipeNameContainer = widthScreen * 453 / 768;
      boxAndTopSpacing = heightScreen * 20 / 1024;
      widthBox = widthScreen * 531 / 768;
      boxContextPadding = widthScreen * 15 / 768;
      boxContentAndTopSpacing = heightScreen * 15 / 1024;
      widthEditIcon = widthScreen * 24 / 768;
      heightEditIcon = heightScreen * 24 / 1024;
      widthAddBox = widthScreen * 501 / 768;
      hightAddBox = heightScreen * 50 / 1024;
      saveTextAndFormSpacing = heightScreen * 50 / 1024;
      saveButtonSpacing = heightScreen * 10 / 1024;
      widthField = widthScreen * 450 / 768;
      saveAndPostButtonSpacing = widthScreen * 15 / 768;
      boxAndBottomSpacing = heightScreen * 15 / 1024;
      widthIngredientAddIcon = 70;
      heightIngredientAddIcon = 50;
      boderRadius = 8;
      heightText = 1.375;
    }

    return BlocBuilder<CreateRecipeBloc, CreateRecipeState>(
        builder: (context, state) {
      createRecipe(context, state);
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: createFormPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  recipeImage.path == ""
                      ? Container(
                          width: widthAddRecipeImage,
                          height: heightAddRecipeImage,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(boderRadius),
                              border: Border.all(
                                color: CreateRecipeColor.boxBorderColor,
                                width: 1,
                              )),
                          child: TextButton(
                            onPressed: () {
                              showRecipeImage(context);
                            },
                            child: Image(
                              width: 20,
                              height: 20,
                              image: AssetImage('assets/icons/add_icon.png'),
                            ),
                          ))
                      : Container(
                          width: widthAddRecipeImage,
                          height: heightAddRecipeImage,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            child: Image.file(
                              recipeImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(width: addRecipeImageAndNameSpacing),
                  Container(
                    height: heightRecipeNameContainer,
                    width: widthRecipeNameContainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(CreateRecipeText.recipeName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontFamily: AppConstants.fontRegular,
                                    color: CreateRecipeColor.textColor)),
                        Spacer(),
                        TextFormField(
                          controller: recipeNameController,
                          cursorColor: CreateRecipeColor.cursorColor,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: CreateRecipeText.recipeNameHintText,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: CreateRecipeColor.cursorColor)),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      fontFamily: AppConstants.fontRegular,
                                      color: CreateRecipeColor.mainTextColor
                                          .withOpacity(0.5))),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: boxAndTopSpacing),
              Container(
                width: widthBox,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(boderRadius),
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
                  padding: EdgeInsets.symmetric(horizontal: boxContextPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: boxContentAndTopSpacing),
                      Row(
                        children: [
                          Text(
                            CreateRecipeText.gallery,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontFamily: AppConstants.fontBold,
                                    height: heightText,
                                    color: CreateRecipeColor.mainTextColor),
                          ),
                          Spacer(),
                          Image(
                            image: AssetImage('assets/icons/edit_icon.png'),
                            width: widthEditIcon,
                            height: heightEditIcon,
                          )
                        ],
                      ),
                      galleryImage.length == 0
                          ? SizedBox()
                          : Container(
                              child: StaggeredGridView.countBuilder(
                                  padding: EdgeInsets.only(top: 10, bottom: 5),
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  itemCount: galleryImage.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(boderRadius)),
                                      child: Image.file(
                                          File(galleryImage[index].path),
                                          fit: BoxFit.cover),
                                    );
                                  },
                                  staggeredTileBuilder: (int index) =>
                                      StaggeredTile.count(
                                          (index % 4 == 0) ? 1 : 1,
                                          (index % 4 == 0) ? 1 : 1),
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(boderRadius),
                              ),
                            ),
                      SizedBox(height: editIconAndBottomSpacing),
                      Container(
                        width: widthAddBox,
                        height: hightAddBox,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(boderRadius),
                          border: Border.all(
                              width: 1,
                              color: CreateRecipeColor.boxBorderColor),
                        ),
                        child: InkWell(
                          onTap: () {
                            showGalleryImage(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image(
                                  image:
                                      AssetImage('assets/icons/add_icon.png'),
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                CreateRecipeText.galleryHintText,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontFamily: AppConstants.fontRegular,
                                        height: heightText,
                                        color: CreateRecipeColor.mainTextColor
                                            .withOpacity(0.5)),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: boxAndBottomSpacing),
                    ],
                  ),
                ),
              ),
              SizedBox(height: boxAndTopSpacing),
              Container(
                width: widthBox,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(boderRadius),
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
                  padding: EdgeInsets.symmetric(horizontal: boxContextPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: boxContentAndTopSpacing),
                      Row(
                        children: [
                          Text(
                            CreateRecipeText.ingredients,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontFamily: AppConstants.fontBold,
                                    height: 1.375,
                                    color: CreateRecipeColor.mainTextColor),
                          ),
                          Spacer(),
                          Image(
                            image: AssetImage('assets/icons/edit_icon.png'),
                            width: widthEditIcon,
                            height: heightEditIcon,
                          )
                        ],
                      ),
                      SizedBox(height: editIconAndBottomSpacing),
                      AddIngredient(ingredientList: ingredientList),
                      Container(
                        width: widthAddBox,
                        height: hightAddBox,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(boderRadius),
                          border: Border.all(
                              width: 1,
                              color: CreateRecipeColor.boxBorderColor),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (ingredientController.text.isNotEmpty) {
                                  BlocProvider.of<CreateRecipeBloc>(context)
                                      .add(CreateRecipeIngredientAdded(
                                          ingredientText:
                                              ingredientController.text,
                                          ingredientImage: ingredientImage));
                                  setState(() {
                                    ingredientController.text = "";
                                    ingredientImage = File("");
                                  });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image(
                                  image:
                                      AssetImage('assets/icons/add_icon.png'),
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                            Flexible(
                                child: Container(
                              width: widthField,
                              height: hightAddBox,
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: ingredientController,
                                cursorColor: CreateRecipeColor.cursorColor,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText:
                                      CreateRecipeText.ingredientsHintText,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontFamily: AppConstants.fontRegular,
                                          height: heightText,
                                          color: CreateRecipeColor.mainTextColor
                                              .withOpacity(0.5)),
                                ),
                              ),
                            )),
                            SizedBox(width: 20),
                            Container(
                                width: widthIngredientAddIcon,
                                height: heightIngredientAddIcon,
                                child: ingredientImage.path == ''
                                    ? TextButton(
                                        onPressed: () {
                                          BlocProvider.of<CreateRecipeBloc>(
                                                  context)
                                              .add(
                                                  CreateRecipeIngredientImagePicked());
                                        },
                                        child: Image(
                                          image: AssetImage(
                                              'assets/icons/image_add_icon.png'),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)),
                                        child: Image.file(
                                          ingredientImage,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                      SizedBox(height: boxAndBottomSpacing),
                    ],
                  ),
                ),
              ),
              SizedBox(height: boxAndTopSpacing),
              Container(
                width: widthBox,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(boderRadius),
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
                  padding: EdgeInsets.symmetric(horizontal: boxContextPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: boxContentAndTopSpacing),
                      Row(
                        children: [
                          Text(
                            CreateRecipeText.howToCook,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontFamily: AppConstants.fontBold,
                                    height: heightText,
                                    color: CreateRecipeColor.mainTextColor),
                          ),
                          Spacer(),
                          Image(
                            image: AssetImage('assets/icons/edit_icon.png'),
                            width: widthEditIcon,
                            height: heightEditIcon,
                          )
                        ],
                      ),
                      SizedBox(height: editIconAndBottomSpacing),
                      AddCookRecipeBox(cookRecipeList: directionList),
                      Container(
                        width: widthAddBox,
                        height: hightAddBox,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(boderRadius),
                          border: Border.all(
                              width: 1,
                              color: CreateRecipeColor.boxBorderColor),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (directionController.text.isNotEmpty) {
                                  BlocProvider.of<CreateRecipeBloc>(context)
                                      .add(CreateRecipeDirectionAdded(
                                          direction: directionController.text));
                                  setState(() {
                                    directionController.text = "";
                                  });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image(
                                  image:
                                      AssetImage('assets/icons/add_icon.png'),
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: widthField,
                              height: hightAddBox,
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: directionController,
                                cursorColor: CreateRecipeColor.cursorColor,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: CreateRecipeText.howToCookHintText,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontFamily: AppConstants.fontRegular,
                                          height: heightText,
                                          color: CreateRecipeColor.mainTextColor
                                              .withOpacity(0.5)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: boxAndBottomSpacing),
                    ],
                  ),
                ),
              ),
              SizedBox(height: boxAndTopSpacing),
              Container(
                width: widthBox,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(boderRadius),
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
                  padding: EdgeInsets.symmetric(horizontal: boxContextPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: boxContentAndTopSpacing),
                      Row(
                        children: [
                          Text(
                            CreateRecipeText.additionalInfo,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontFamily: AppConstants.fontBold,
                                    height: heightText,
                                    color: CreateRecipeColor.mainTextColor),
                          ),
                          Spacer(),
                          Image(
                            image: AssetImage('assets/icons/edit_icon.png'),
                            width: widthEditIcon,
                            height: heightEditIcon,
                          )
                        ],
                      ),
                      SizedBox(height: editIconAndBottomSpacing),
                      Container(
                        width: widthAddBox,
                        height: hightAddBox,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(boderRadius),
                          border: Border.all(
                              width: 1,
                              color: CreateRecipeColor.boxBorderColor),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isAddInfo = true;
                            });
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Image(
                                  image:
                                      AssetImage('assets/icons/add_icon.png'),
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(CreateRecipeText.additionalInfoHintText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontFamily: AppConstants.fontRegular,
                                          height: heightText,
                                          color: Color(0xFF030f09)
                                              .withOpacity(0.5)))
                            ],
                          ),
                        ),
                      ),
                      isAddInfo ? AddInfo() : SizedBox(),
                      SizedBox(height: boxAndBottomSpacing),
                    ],
                  ),
                ),
              ),
              SizedBox(height: saveTextAndFormSpacing),
              Text(
                CreateRecipeText.saveTo,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontFamily: AppConstants.fontRegular,
                    height: 1.57,
                    color: CreateRecipeColor.saveTextColor),
              ),
              SizedBox(height: saveButtonSpacing),
              Responsive.isTablet(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SaveRecipeButton(
                          durationList: directionList,
                          recipeName: recipeNameController.text,
                          recipeImage: recipeImage,
                          galleryImage: galleryImage,
                          ingredientList: ingredientList,
                          servingTime: time,
                          nutrition: nutrition,
                          tag: tag,
                        ),
                        SizedBox(width: saveAndPostButtonSpacing),
                        PostToFeedButton()
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SaveRecipeButton(
                          durationList: directionList,
                          recipeName: recipeNameController.text,
                          recipeImage: recipeImage,
                          galleryImage: galleryImage,
                          ingredientList: ingredientList,
                          servingTime: time,
                          nutrition: nutrition,
                          tag: tag,
                        ),
                        SizedBox(height: saveAndPostButtonSpacing),
                        PostToFeedButton()
                      ],
                    ),
            ],
          ),
        ),
      );
    });
  }
}

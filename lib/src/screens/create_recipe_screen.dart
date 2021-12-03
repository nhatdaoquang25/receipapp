import 'package:flutter/material.dart';

import '../widgets/responsive.dart';
import '../constants/constants_text.dart';
import '../widgets/create_recipe/create_recipe_form.dart';
import '../widgets/create_recipe/back_button.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({Key? key}) : super(key: key);

  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    var checkTablet = false;
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double contextAndTopSpacing = heightScreen * 11 / 812;
    double backButtonAndBottomSpacing = heightScreen * 15 / 812;
    double titlePadding = widthScreen * 25 / 375;
    double createFormAndTopSpacing = heightScreen * 33 / 812;
    double contextAndBottomPadding = heightScreen * 36 / 812;

    if (Responsive.isTablet(context)) {
      checkTablet = true;
      heightScreen = MediaQuery.of(context).size.height;
      widthScreen = MediaQuery.of(context).size.width;
      contextAndTopSpacing = heightScreen * 76 / 1024;
      backButtonAndBottomSpacing = heightScreen * 15 / 1024;
      titlePadding = widthScreen * 119 / 768;
      createFormAndTopSpacing = heightScreen * 25 / 1024;
      contextAndBottomPadding = heightScreen * 70 / 1024;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: contextAndTopSpacing),
              RecipeBackButton(),
              SizedBox(height: backButtonAndBottomSpacing),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: titlePadding),
                child: Text(
                  checkTablet
                      ? CreateRecipeText.titleTablet
                      : CreateRecipeText.titleMobile,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontFamily: AppConstants.fontBold),
                ),
              ),
              SizedBox(height: createFormAndTopSpacing),
              CreateRecipeForm(),
              SizedBox(height: contextAndBottomPadding),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../constants/constants_text.dart';
import '../../constants/constants_color.dart';
import '../../widgets/responsive.dart';

class RecipeBackButton extends StatefulWidget {
  const RecipeBackButton({Key? key}) : super(key: key);

  @override
  _RecipeBackButtonState createState() => _RecipeBackButtonState();
}

class _RecipeBackButtonState extends State<RecipeBackButton> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double backButtonPadding = widthScreen * 20 / 375;
    double widthBackButton = widthScreen * 135 / 375;
    double heightBackButton = heightScreen * 20 / 812;
    double backIconAndTextPadding = widthScreen * 7 / 375;
    if (Responsive.isTablet(context)) {
      heightScreen = MediaQuery.of(context).size.height;
      widthScreen = MediaQuery.of(context).size.width;
      backButtonPadding = widthScreen * 113 / 768;
      widthBackButton = widthScreen * 135 / 768;
      heightBackButton = heightScreen * 20 / 1024;
      backIconAndTextPadding = widthScreen * 7 / 768;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: backButtonPadding),
      child: Container(
        width: widthBackButton,
        height: heightBackButton,
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/icons/back_icon.png'),
                width: 20,
                height: 20,
              ),
              SizedBox(width: backIconAndTextPadding),
              Flexible(
                child: Text(
                  CreateRecipeText.backRecipes,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                      fontFamily: AppConstants.fontRegular,
                      height: 1.33,
                      letterSpacing: 0.4,
                      color: CreateRecipeColor.backTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

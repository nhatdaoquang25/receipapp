import 'package:flutter/material.dart';

import '../../widgets/responsive.dart';
import '../../constants/constants_text.dart';
import '../../constants/constants_color.dart';

class PostToFeedButton extends StatefulWidget {
  const PostToFeedButton({Key? key}) : super(key: key);

  @override
  _PostToFeedButtonState createState() => _PostToFeedButtonState();
}

class _PostToFeedButtonState extends State<PostToFeedButton> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double widthPostButton = widthScreen * 325 / 375;
    double heightPostButton = heightScreen * 50 / 812;
    if (Responsive.isTablet(context)) {
      widthPostButton = widthScreen * 155 / 768;
      heightPostButton = heightScreen * 50 / 1024;
    }
    return Container(
      width: widthPostButton,
      height: heightPostButton,
      decoration: BoxDecoration(
        color: CreateRecipeColor.cursorColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          CreateRecipeText.postButton,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontFamily: AppConstants.fontBold,
              color: Colors.white,
              height: 1.31),
        ),
      ),
    );
  }
}

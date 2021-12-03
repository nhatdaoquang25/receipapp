import 'package:flutter/material.dart';


import '../models/fake_data.dart';
import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import 'responsive.dart';

class CategoryItem extends StatelessWidget {
  final double mediumTextSize = 16;
  Category category;
  CategoryItem({required this.category});
  @override
  Widget build(BuildContext context) {
    double recipeCardHeight = 183;
    double spacingImageToTitle = 11.5;
    double imageHeight = 150;
    if (Responsive.isMobile(context)) {
      recipeCardHeight = 132;
      spacingImageToTitle = 5;
      imageHeight = 100;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: recipeCardHeight,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                image: category.urlPicture.isEmpty
                    ? DecorationImage(
                        image: AssetImage('assets/images/dot.png'),
                        fit: BoxFit.fill)
                    : DecorationImage(
                        image: NetworkImage('${category.urlPicture}'),
                        fit: BoxFit.fill)),
            height: imageHeight,
          ),
          SizedBox(
            height: spacingImageToTitle,
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Center(
                child: Text(
                  "${this.category.content}",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontFamily: AppConstants.fontRegular,
                        color: AppColors.appTitle,
                        fontSize: mediumTextSize,
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

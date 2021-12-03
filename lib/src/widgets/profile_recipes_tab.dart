import 'package:flutter/material.dart';

import '../models/fake_data.dart';
import 'profile_categoryitem.dart';
import 'responsive.dart';

class RecipesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double mainAxisSpacing = 20;
    double crossAxisSpacing = 34;
    double childAspectRatio = 2.087;
    if (Responsive.isMobile(context)) {
      crossAxisSpacing = 15;
      mainAxisSpacing = 15;
      childAspectRatio = 1.2;
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: GridView(
        clipBehavior: Clip.none,
        children: Fake_Category.map((eachCategory) => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 6),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: CategoryItem(category: eachCategory))).toList(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio),
      ),
    );
  }
}

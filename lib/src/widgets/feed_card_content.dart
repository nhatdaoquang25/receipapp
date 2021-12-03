import 'package:flutter/material.dart';

import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import '../models/feed_card_model.dart';
import '../utils/data_converter.dart';
import 'responsive.dart';

class FeedCardContent extends StatelessWidget {
  const FeedCardContent({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final FeedCardModel recipe;
  final double mobileTitleWidth = 220;
  final double tabletTitleWidth = 400;
  final double mobileDescriptionWidth = 265;
  final double tabletDescriptionWidth = 448;
  final double mobileDescriptionHeight = 44;
  final double tabletDescriptionHeight = 75;
  final double favoriteIconSize = 24;
  final double mobileDescriptionTopSpacing = 10;
  final double tabletDescriptionTopSpacing = 3;
  final int mobileDescriptionLimitedLength = 65;
  final int tabletDescriptionLimitedLength = 175;
  final double mobileDescriptionBottomSpacing = 20;
  final double tabletDescriptionBottomSpacing = 34;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Responsive.isMobile(context)
                  ? mobileTitleWidth
                  : tabletTitleWidth,
              child: Text(
                recipe.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontFamily: AppConstants.fontSemiBold,
                      fontSize: 18,
                      color: AppColors.appTitle,
                      height: 1.6,
                      letterSpacing: 0.3,
                    ),
              ),
            ),
            Image.asset(
              'assets/icons/favorite_icon.png',
              height: favoriteIconSize,
              width: favoriteIconSize,
            ),
          ],
        ),
        SizedBox(
          height: Responsive.isMobile(context)
              ? mobileDescriptionTopSpacing
              : tabletDescriptionTopSpacing,
        ),
        SizedBox(
          height: Responsive.isMobile(context)
              ? mobileDescriptionHeight
              : tabletDescriptionHeight,
          width: Responsive.isMobile(context)
              ? mobileDescriptionWidth
              : tabletDescriptionWidth,
          child: Text(
            '${Responsive.isMobile(context) ? recipe.description.length > mobileDescriptionLimitedLength ? '${recipe.description.substring(0, mobileDescriptionLimitedLength)}...' : recipe.description : recipe.description.length > tabletDescriptionLimitedLength ? '${recipe.description.substring(0, tabletDescriptionLimitedLength)}...' : recipe.description}',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColors.cardContent,
                  height: 1.6,
                ),
          ),
        ),
        SizedBox(
          height: Responsive.isMobile(context)
              ? mobileDescriptionBottomSpacing
              : tabletDescriptionBottomSpacing,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Wrap(
                children: [
                  Text(
                    '${DataConverter.getReaction(recipe.likes)} ${FeedText.likes}',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColors.subTitle, letterSpacing: 0.2),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      top: Responsive.isMobile(context) ? 7.5 : 5.5,
                      right: 8,
                    ),
                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color: AppColors.cardDot,
                    ),
                  ),
                  Text(
                    '${DataConverter.getReaction(recipe.comments)} ${FeedText.comments}',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColors.subTitle, letterSpacing: 0.2),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 26,
              width: 70,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: BorderSide(
                    color: AppColors.mainTheme,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.mainTheme,
                        size: 14,
                      ),
                      Flexible(
                        child: Text(
                          FeedText.saveButton,
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontFamily: AppConstants.fontBasic,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.4,
                                    color: AppColors.mainTheme,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

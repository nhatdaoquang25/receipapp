import 'package:flutter/material.dart';

import '../models/feed_card_model.dart';
import '../models/user_model.dart';
import 'feed_card_content.dart';
import 'feed_card_header.dart';

class MobileFeedCard extends StatelessWidget {
  final double cardWidth = 295;
  final double imageHeight = 396;
  final double nameCardHeight = 62;
  final double contentPadding = 15;
  final double standardRadius = 8;

  final FeedCardModel recipe;

  final UserModel author;

  MobileFeedCard({
    required this.recipe,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(standardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 6),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(standardRadius),
              ),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Image.network(
                    '${recipe.imageURL}',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: imageHeight,
                  ),
                  ColoredBox(
                    color: Colors.white.withOpacity(0.95),
                    child: SizedBox(
                      height: nameCardHeight,
                      child: Padding(
                        padding: EdgeInsets.only(left: contentPadding),
                        child: FeedCardHeader(
                          author: author,
                          recipe: recipe,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(contentPadding),
              child: FeedCardContent(
                recipe: recipe,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

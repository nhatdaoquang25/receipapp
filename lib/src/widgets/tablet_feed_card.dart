import 'package:flutter/material.dart';

import '../models/feed_card_model.dart';
import '../models/user_model.dart';
import 'feed_card_content.dart';
import 'feed_card_header.dart';

class TabletFeedCard extends StatelessWidget {
  final double cardWidth = 718;
  final double contentWidth = 474;
  final double imageSize = 244;
  final double contentPadding = 15;
  final double standardRadius = 8;

  final FeedCardModel recipe;

  final UserModel author;

  TabletFeedCard({
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
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(standardRadius),
          ),
          child: Row(
            children: [
              Image.network(
                '${recipe.imageURL}',
                fit: BoxFit.cover,
                width: imageSize,
                height: imageSize,
              ),
              Container(
                padding: EdgeInsets.all(contentPadding),
                width: contentWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeedCardHeader(author: author, recipe: recipe),
                    SizedBox(
                      height: contentPadding,
                    ),
                    FeedCardContent(
                      recipe: recipe,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

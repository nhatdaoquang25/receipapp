import 'package:flutter/material.dart';

import '../constants/constants_color.dart';
import '../models/feed_card_model.dart';
import '../models/user_model.dart';
import '../utils/data_converter.dart';

class FeedCardHeader extends StatelessWidget {
  const FeedCardHeader({
    Key? key,
    required this.author,
    required this.recipe,
  }) : super(key: key);

  final double avatarSize = 32;
  final double avatarPadding = 10;
  final UserModel author;
  final FeedCardModel recipe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: avatarSize,
          height: avatarSize,
          child: CircleAvatar(
            backgroundImage: NetworkImage('${author.avatarURL}'),
            foregroundColor: Colors.transparent,
          ),
        ),
        SizedBox(
          width: avatarPadding,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              author.name,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: AppColors.profileTitle,
                  ),
            ),
            Text(
              DataConverter.getFeedTime(recipe.postTime),
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: AppColors.profileSubTitle,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

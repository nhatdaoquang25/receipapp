import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../constants/constants_color.dart';
import '../constants/constants_text.dart';

class ProfileInfomationCard extends StatefulWidget {
  @override
  _ProfileInfomationCardState createState() => _ProfileInfomationCardState();
}

class _ProfileInfomationCardState extends State<ProfileInfomationCard> {
  final double mainPaddingHorizontal = 25;
  final double paddingLeftNextToAvatar = 15;
  final double spacingWithDivider = 25;
  final double avatarSize = 82.0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mainPaddingHorizontal),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Container(
                            width: avatarSize,
                            height: avatarSize,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(user.avatarURL)))),
                        Padding(
                          padding:
                              EdgeInsets.only(left: paddingLeftNextToAvatar),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${user.name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontFamily: AppConstants.fontBold,
                                        color: AppColors.appTitle,
                                      )),
                              Text('${user.nickName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        fontFamily: AppConstants.fontRegular,
                                        color: AppColors.subTitle,
                                      )),
                              SizedBox(
                                height: 11,
                              ),
                              Row(
                                children: [
                                  Text("${user.follow} followers",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontFamily:
                                                AppConstants.fontRegular,
                                            color: AppColors.subTitle,
                                          )),
                                  Image.asset('assets/images/dot.png'),
                                  Text("${user.like} likes",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                            fontFamily:
                                                AppConstants.fontRegular,
                                            color: AppColors.subTitle,
                                          )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Image.asset('assets/icons/edit.png'),
                  ),
                ],
              ),
              SizedBox(
                height: spacingWithDivider,
              ),
              Divider(
                thickness: 0.5,
              ),
            ],
          ),
        )
      ],
    );
  }
}

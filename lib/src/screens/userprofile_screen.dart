import 'package:flutter/material.dart';
import '../widgets/profile_tabbar.dart';

import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import '../widgets/profile_infomation_card.dart';
import '../widgets/responsive.dart';
import '../widgets/top_bar_tablet.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final double largeTextSize = 24;
  final double paddingTop = 49;
  final double paddingLeft = 25;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: paddingTop, left: paddingLeft),
              child: Text(
                ProfileText.titleProfile,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontFamily: AppConstants.fontBold,
                      color: AppColors.appTitle,
                      fontSize: largeTextSize,
                    ),
              ),
            ),
            ProfileInfomationCard(),
            Expanded(child: TabBarProfile()),
          ],
        ),
        tablet: Column(
          children: [
            TopBar(),
            ProfileInfomationCard(),
            Expanded(child: TabBarProfile()),
          ],
        ),
      ),
    );
  }
}

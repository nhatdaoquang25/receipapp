import 'package:flutter/material.dart';

import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import 'profile_recipes_tab.dart';

class TabBarProfile extends StatefulWidget {
  @override
  _TabBarProfileState createState() => _TabBarProfileState();
}

class _TabBarProfileState extends State<TabBarProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final double mainPaddingHorizontal = 25;
  final String countRecipes = "20";
  final String countSaved = "75";
  final String countFollowing = "248";
  final int fristTabbar =0;
  final int thirdTabbar =2;
  
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: Color(0xffE6E6E6)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mainPaddingHorizontal),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.mainTheme,
              indicatorPadding:  _tabController.index == fristTabbar ? EdgeInsets.only(right: 20): _tabController.index == thirdTabbar ? EdgeInsets.only(left: 20) : EdgeInsets.zero,
              tabs: <Widget>[
                Tab(
                  child: Column(
                    children: [
                      Text(
                        countRecipes,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontFamily: AppConstants.fontBold,
                              color: _tabController.index == 0
                                  ? AppColors.appTitle
                                  : AppColors.appTitle.withOpacity(0.4),
                              fontSize: 20,
                            ),
                      ),
                      Flexible(
                        child: Text(
                          ProfileText.titleTabRecipes,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontFamily: AppConstants.fontBold,
                                    color: _tabController.index == 0
                                        ? AppColors.appTitle
                                        : AppColors.appTitle.withOpacity(0.4),
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                    child: Column(
                  children: [
                    Text(
                      countSaved,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontFamily: AppConstants.fontBold,
                            color: _tabController.index == 1
                                ? AppColors.appTitle
                                : AppColors.appTitle.withOpacity(0.4),
                            fontSize: 20,
                          ),
                    ),
                    Text(
                      ProfileText.titleTabSaved,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontFamily: AppConstants.fontBold,
                            color: _tabController.index == 1
                                ? AppColors.appTitle
                                : AppColors.appTitle.withOpacity(0.4),
                            fontSize: 16,
                          ),
                    ),
                  ],
                )),
                Tab(
                    child: Column(
                  children: [
                    Text(
                      countFollowing,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontFamily: AppConstants.fontBold,
                            color: _tabController.index == 2
                                ? AppColors.appTitle
                                : AppColors.appTitle.withOpacity(0.4),
                            fontSize: 20,
                          ),
                    ),
                    Flexible(
                      child: Text(
                        ProfileText.titleTabFollowing,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontFamily: AppConstants.fontBold,
                              color: _tabController.index == 2
                                  ? AppColors.appTitle
                                  : AppColors.appTitle.withOpacity(0.4),
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: _tabController,
            children: [
              RecipesTab(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        )
      ],
    );
  }
}

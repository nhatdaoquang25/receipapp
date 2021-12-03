import 'package:flutter/material.dart';

import '../constants/constants_color.dart';
import '../widgets/responsive.dart';
import '../widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Responsive.isTablet(context)
              ? Padding(
                  padding: EdgeInsets.only(top: 75),
                  child: Divider(
                    color: AppColors.inactiveTabButton,
                    height: 1,
                  ),
                )
              : SizedBox.shrink(),
          SearchBox(),
        ],
      )),
    );
  }
}

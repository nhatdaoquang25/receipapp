import 'package:flutter/material.dart';

import '../screens/search_screen.dart';
import '../screens/feed_screen.dart';
import '../constants/constants_color.dart';
import '../screens/userprofile_screen.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigator createState() => _BottomNavigator();
}

class _BottomNavigator extends State<BottomNavigator> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    SearchScreen(),
    FeedScreen(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image(
                  image: AssetImage('assets/icons/search_icon.png'),
                  width: 32,
                  height: 32,
                  color: _selectedIndex == 0
                      ? AppColors.activeTabButton
                      : AppColors.inactiveTabButton),
              label: ''),
          BottomNavigationBarItem(
              icon: Image(
                  image: AssetImage('assets/icons/feed_icon.png'),
                  width: 32,
                  height: 32,
                  color: _selectedIndex == 1
                      ? AppColors.activeTabButton
                      : AppColors.inactiveTabButton),
              label: ''),
          BottomNavigationBarItem(
              icon: Image(
                  image: AssetImage('assets/icons/user_profile_icon.png'),
                  width: 32,
                  height: 32,
                  color: _selectedIndex == 2
                      ? AppColors.activeTabButton
                      : AppColors.inactiveTabButton),
              label: '')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

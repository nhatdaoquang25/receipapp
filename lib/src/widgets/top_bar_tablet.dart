import 'package:flutter/material.dart';

import 'logo.dart';
import 'responsive.dart';

class TopBar extends StatelessWidget {
  static const double paddingAllItemsInTopBar = 25;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(paddingAllItemsInTopBar),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Image.asset('assets/icons/icon_search.png')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child:
                              Image.asset('assets/icons/icon_notification.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: GestureDetector(
                              onTap: () {},
                              child: Image.asset('assets/icons/icon_mail.png')),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.brown.shade800,
                          radius: 14,
                        )
                      ],
                    ),
                  ],
                ),
                Logo(),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}

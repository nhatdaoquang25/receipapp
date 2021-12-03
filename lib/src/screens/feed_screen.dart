import 'package:flutter/material.dart';

import '../widgets/feed_card_carousel.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 88, bottom: 90),
        child: FeedCardCarousel(),
      ),
    );
  }
}

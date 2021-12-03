import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/feed/feed_card_bloc.dart';
import '../blocs/feed/feed_card_event.dart';
import '../blocs/feed/feed_card_state.dart';
import '../constants/constants_color.dart';
import 'mobile_feed_card.dart';
import 'tablet_feed_card.dart';
import 'responsive.dart';

class FeedCardCarousel extends StatefulWidget {
  FeedCardCarousel({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _FeedCardCarouselState createState() => _FeedCardCarouselState();
}

class _FeedCardCarouselState extends State<FeedCardCarousel> {
  final pageController = PageController(
    viewportFraction: 0.84,
  );

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCardBloc, FeedCardState>(
      builder: (context, state) {
        if (state is FeedCardLoadSuccess) {
          return Responsive.isMobile(context)
              ? PageView.builder(
                  controller: pageController,
                  onPageChanged: (page) => setState(() => currentPage = page),
                  itemCount: state.recipes.length,
                  itemBuilder: (_, index) => index == currentPage
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: MobileFeedCard(
                            author: state.authors[index],
                            recipe: state.recipes[index],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Opacity(
                            opacity: 0.5,
                            child: MobileFeedCard(
                              author: state.authors[index],
                              recipe: state.recipes[index],
                            ),
                          ),
                        ))
              : ListView.separated(
                  separatorBuilder: (_, index) => SizedBox(
                    height: 20,
                  ),
                  itemCount: state.recipes.length,
                  itemBuilder: (_, index) => TabletFeedCard(
                    author: state.authors[index],
                    recipe: state.recipes[index],
                  ),
                );
        } else if (state is FeedCardLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.mainTheme,
              strokeWidth: 3,
            ),
          );
        } else if (state is FeedCardInitial) {
          context.read<FeedCardBloc>().add(FeedCardDataRequested());
          return SizedBox.shrink();
        } else {
          state as FeedCardLoadFailure;
          return Center(
            child: Text(state.error),
          );
        }
      },
    );
  }
}

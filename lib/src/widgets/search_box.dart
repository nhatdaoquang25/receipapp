import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/recipe_model.dart';
import '../blocs/recipe/recipe_event.dart';
import '../blocs/recipe/recipe_bloc.dart';
import '../blocs/recipe/recipe_state.dart';
import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import 'responsive.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController _searchController = TextEditingController();
  Timer? _timer;
  List<RecipeModel> _searchList = [];
  String messageSearchFailure = '';
  bool _searching = false;
  bool _searchListLoaded = false;
  double paddingHorizontal = 25;
  double spacingIcon = 38;
  @override
  Widget build(BuildContext context) {
    double widthShowSuggestionText = Responsive.isTablet(context)
        ? MediaQuery.of(context).size.width / 1.4
        : MediaQuery.of(context).size.width;
    var hintText = Responsive.isTablet(context)
        ? SearchText.hintTextTablet
        : SearchText.hintText;

    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case RecipeInitial:
            _searching = false;
            _searchList = [];
            _searchListLoaded = false;
            break;
          case RecipeSearchLoading:
            _searching = true;
            break;
          case RecipeSearchSuccess:
            state as RecipeSearchSuccess;
            _searching = false;
            _searchList = state.recipeTextFieldValue;
            break;
          case RecipeSearchFailure:
            state as RecipeSearchFailure;
            _searching = false;
            _searchList = [];
            _searchListLoaded = true;
            messageSearchFailure = state.failMessage;
            break;
          case RecipeSelectedSuccess:
            state as RecipeSelectedSuccess;
            _searching = false;
            _searchList = [];
            _searchListLoaded = false;
            hintText = state.recipeName;
            break;
          case RecipeSearchTextFieldEmptyChangedSuccess:
            state as RecipeSearchTextFieldEmptyChangedSuccess;
            FocusScope.of(context).unfocus();
            break;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Container(
                  height: 46,
                  padding: EdgeInsets.only(right: 11),
                  decoration: BoxDecoration(
                      color: Responsive.isTablet(context)
                          ? Colors.transparent
                          : Colors.white,
                      borderRadius: _searchList.length != 0 ||
                              _searching == true ||
                              messageSearchFailure.isNotEmpty
                          ? BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))
                          : BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Responsive.isTablet(context)
                              ? Colors.white.withOpacity(0)
                              : Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            if (_timer?.isActive ?? false) _timer?.cancel();
                            _timer =
                                Timer(const Duration(milliseconds: 500), () {
                              context
                                  .read<RecipeBloc>()
                                  .add(RecipeTextFieldChanged(value));
                            });
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.logoText,
                                size: 24,
                              ),
                              hintText: hintText,
                              hintStyle: TextStyle(
                                color: AppColors.fieldTitle,
                              )),
                        ),
                      ),
                      InkWell(
                          onTap: () {},
                          child: Image(
                            image: AssetImage('assets/icons/filter_icon.png'),
                            color: AppColors.logoText,
                          )),
                      Responsive.isTablet(context)
                          ? SizedBox(
                              width: spacingIcon,
                            )
                          : SizedBox.shrink(),
                      Responsive.isTablet(context)
                          ? Row(
                              children: [
                                InkWell(
                                    onTap: () {},
                                    child: Image(
                                      image: AssetImage(
                                          'assets/icons/notification_icon.png'),
                                      color: AppColors.logoText,
                                    )),
                                SizedBox(
                                  width: spacingIcon,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Image(
                                      image: AssetImage(
                                          'assets/icons/email_icon.png'),
                                      color: AppColors.logoText,
                                    )),
                                SizedBox(
                                  width: spacingIcon,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/icons/avatar_icon.png"),
                                    ))
                              ],
                            )
                          : SizedBox.shrink()
                    ],
                  )),
            ),
            Responsive.isTablet(context) ||
                    _searchList.length != 0 ||
                    _searching == true
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: paddingHorizontal),
                    child: SizedBox(
                      width: widthShowSuggestionText,
                      child: Divider(
                        color: Responsive.isTablet(context)
                            ? AppColors.fieldText
                            : AppColors.inactiveTabButton,
                        height: 1,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Container(
                  height: messageSearchFailure.isNotEmpty ? 50 : null,
                  padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                  width: widthShowSuggestionText,
                  color: Colors.white,
                  child: _searching
                      ? Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainTheme,
                            ),
                          ),
                        )
                      : _searchList.length != 0 &&
                              _searchController.text.length != 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    _searchList.length >= 7
                                        ? 7
                                        : _searchList.length,
                                    (index) => Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: InkWell(
                                            onTap: () {
                                              _searchController.clear();
                                              FocusScope.of(context).unfocus();
                                              context.read<RecipeBloc>().add(
                                                  RecipeSearchSelected(
                                                      _searchList[index].label,
                                                      _searchList[index].id));
                                            },
                                            child: HightlightKeyword(
                                              keyWordHighlight:
                                                  _searchController.text,
                                              searchResultText:
                                                  _searchList[index]
                                                      .label
                                                      .toLowerCase(),
                                            ))))
                              ],
                            )
                          : _searchListLoaded
                              ? Center(
                                  child: Text(
                                  messageSearchFailure,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontFamily: AppConstants.fontBasic,
                                      ),
                                ))
                              : SizedBox.shrink()),
            ),
          ],
        );
      },
    );
  }
}

class HightlightKeyword extends StatelessWidget {
  final String searchResultText;
  final String keyWordHighlight;

  HightlightKeyword(
      {Key? key,
      required this.keyWordHighlight,
      required this.searchResultText});
  @override
  Widget build(BuildContext context) {
    List<TextSpan> _textSpan = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = searchResultText.indexOf(keyWordHighlight, start);
      if (indexOfHighlight < 0) {
        _textSpan.add(_normalText(searchResultText.substring(start)));
        break;
      }
      if (indexOfHighlight > start) {
        _textSpan.add(
            _normalText(searchResultText.substring(start, indexOfHighlight)));
      }
      start = indexOfHighlight + keyWordHighlight.length;
      _textSpan.add(
          _highlightText(searchResultText.substring(indexOfHighlight, start)));
    } while (true);

    return Text.rich(TextSpan(
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontFamily: AppConstants.fontBasic,
              fontSize: 16,
            ),
        children: _textSpan));
  }

  TextSpan _highlightText(String content) {
    return TextSpan(
        text: content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ));
  }

  TextSpan _normalText(String content) {
    return TextSpan(text: content);
  }
}

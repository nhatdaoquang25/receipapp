import 'package:flutter/material.dart';

import 'responsive.dart';
import '../constants/constants_text.dart';
import '../constants/constants_color.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _isOnboardingScreen = key.toString();
    final createKeyOnboardingScreen = "[<OnboardingScreen>]";
    double widthLogo = 18;
    double heightLogo = 26;
    var alignmentText = MainAxisAlignment.start;
    if (_isOnboardingScreen == createKeyOnboardingScreen) {
      widthLogo = 25;
      heightLogo = 36;
      alignmentText = MainAxisAlignment.center;
    }
    if (Responsive.isTablet(context)) {
      alignmentText = MainAxisAlignment.center;
    }
    return Row(
      mainAxisAlignment: alignmentText,
      children: [
        Image.asset(
          "assets/icons/logo_icon.png",
          width: widthLogo,
          height: heightLogo,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.normal,
                fontFamily: AppConstants.fontBold,
                color: AppColors.logoText,
                fontSize: 20,
              ),
        ),
      ],
    );
  }
}

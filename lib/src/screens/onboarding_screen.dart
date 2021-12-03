import 'package:flutter/material.dart';

import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import '../widgets/logo.dart';
import '../widgets/responsive.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthsizebutton = 239;
    double heightsizebutton = 50;
    double spacingLogoWithAppBar = 80;
    double spacingTitleWithSubTitle = 8;
    double spacingSubTitleWithButton = 34;
    double spacingButton = 20;
    AssetImage imgBackgroundTheme =
        AssetImage('assets/images/loading_background.png');
    List<Color> linearGradientColor = [];
    Alignment startAligment = Alignment.topCenter;
    Alignment endAligment = Alignment.bottomCenter;
    double overflowScreenSize = double.infinity;
    if (Responsive.isTablet(context)) {
      linearGradientColor = [
        Colors.white,
        Colors.white,
        Colors.white.withOpacity(0.9),
        Colors.white.withOpacity(0.7),
        Colors.white.withOpacity(0.6),
      ];
    } else {
      linearGradientColor = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white.withOpacity(0.5),
        Colors.white.withOpacity(0.5),
      ];
    }
    return Responsive(
      mobile: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/login');
        },
        child: Container(
          height: overflowScreenSize,
          width: overflowScreenSize,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: imgBackgroundTheme,
                  alignment: endAligment,
                  fit: BoxFit.none,
                  scale: 0.99)),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: startAligment,
                      end: endAligment,
                      colors: linearGradientColor)),
              height: overflowScreenSize,
              child: Logo(
                key: ValueKey(OnboardingScreen),
              ),
            ),
          ),
        ),
      ),
      tablet: Container(
        width: overflowScreenSize,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: imgBackgroundTheme,
          alignment: Alignment(0, 1.1),
          fit: BoxFit.none,
          scale: 0.7,
        )),
        child: SafeArea(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: startAligment,
                      end: endAligment,
                      colors: linearGradientColor)),
              child: Column(
                children: [
                  SizedBox(
                    height: spacingLogoWithAppBar,
                  ),
                  Logo(),
                  Spacer(),
                  Text(
                    OnBoarding.titleOnboarding,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColors.appTitle,
                        fontFamily: AppConstants.fontSemiBold),
                  ),
                  SizedBox(
                    height: spacingTitleWithSubTitle,
                  ),
                  Text(
                    OnBoarding.subtitleOnBoarding,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.normal,
                          color: AppColors.fieldTitle,
                        ),
                  ),
                  SizedBox(
                    height: spacingSubTitleWithButton,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.mainTheme,
                          minimumSize: Size(widthsizebutton, heightsizebutton),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                        child: Text(
                          OnBoarding.buttonJoinScracth,
                          style: Theme.of(context).textTheme.button?.copyWith(
                                color: Colors.white,
                                fontFamily: AppConstants.fontBold,
                              ),
                        ),
                      ),
                      SizedBox(
                        width: spacingButton,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize:
                                Size(widthsizebutton, heightsizebutton),
                            side: BorderSide(
                              color: AppColors.mainTheme,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login');
                          },
                          child: Text(OnBoarding.buttonLearnMore,
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                      color: AppColors.mainTheme,
                                      fontFamily: AppConstants.fontBold)))
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import '../widgets/responsive.dart';
import '../widgets/signup_form.dart';
import '../widgets/logo.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive(
          mobile: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 285,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/cover.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(25, 60, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Logo(),
                      SizedBox(height: 45),
                      Text(SignUpText.titleStartMobile,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontFamily: AppConstants.fontBasic,
                                  color: AppColors.appTitle,
                                  fontSize: 24)),
                    ],
                  ),
                ),
                SignUpForm()
              ],
            ),
          ),
          tablet: Stack(
            children: [
              Image.asset(
                'assets/images/welcome_background.jpeg',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.75),
                        Colors.white.withOpacity(0.85),
                        Colors.white.withOpacity(1),
                      ]),
                ),
              ),
              SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(height: 80),
                  Logo(),
                  SizedBox(height: 130),
                  Text(SignUpText.titleStartTablet,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontFamily: AppConstants.fontBasic,
                          color: AppColors.appTitle,
                          fontSize: 24)),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 547,
                      width: 425,
                      child: SignUpForm())
                ],
              ))
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/login_form.dart';
import '../widgets/responsive.dart';
import '../widgets/logo.dart';
import '../constants/constants_text.dart';
import '../constants/constants_color.dart';

class LoginScreen extends StatelessWidget {
  final double titleTextSize = 24;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Responsive(
        mobile: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                fit: StackFit.loose,
                children: [
                  Image.asset(
                    'assets/images/cover.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 285,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Logo(),
                        SizedBox(
                          height: 45,
                        ),
                        Text(
                          LoginText.titleWelcome,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontFamily: AppConstants.fontBasic,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.appTitle,
                                  fontSize: titleTextSize),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: LoginForm(),
              )
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
                  SizedBox(
                    height: 80,
                  ),
                  Logo(),
                  SizedBox(
                    height: 130,
                  ),
                  Text(
                    LoginText.titleWelcome,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontFamily: AppConstants.fontBold,
                        color: AppColors.appTitle,
                        fontSize: titleTextSize),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                    width: 425,
                    height: 467,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: SingleChildScrollView(
                        child: LoginForm(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

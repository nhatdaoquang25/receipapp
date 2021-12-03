import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums/enums_firebase.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import '../widgets/responsive.dart';
import '../widgets/logo.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double spacingLogoWithAppBar = 65;
    double spacingResetPasswordFormWithLogo = 41;
    double spacingTitleWithResetPasswordForm = 40;
    return Scaffold(
      body: SafeArea(
        child: Responsive(
            mobile: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: spacingLogoWithAppBar,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Logo(),
                  ),
                  SizedBox(
                    height: spacingResetPasswordFormWithLogo,
                  ),
                  ResetPasswordBox(),
                ],
              ),
            ),
            tablet: Stack(
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    'assets/images/welcome_background.jpeg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(1),
                        ]),
                  ),
                ),
                Center(
                    child: Column(
                  children: [
                    Spacer(),
                    Logo(),
                    Spacer(),
                    Text(
                      ForgotPassword.titleHeadStartScratch,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: spacingTitleWithResetPasswordForm,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      height: 547,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ResetPasswordBox(),
                    ),
                    Spacer(
                      flex: 2,
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }
}

class ResetPasswordBox extends StatefulWidget {
  @override
  _ResetPasswordBoxState createState() => _ResetPasswordBoxState();
}

class _ResetPasswordBoxState extends State<ResetPasswordBox> {
  dynamic textEmailError;
  final _email = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeTitleResetPassword = 32;
    double spacingHeadTitle = 0;
    double spacingSubTitle = 23;
    double spacingTextBox = 138;
    double spacingButton = 53;
    double widthSizeScreen = MediaQuery.of(context).size.width;
    double paddingScreen = 25;
    if (Responsive.isTablet(context)) {
      sizeTitleResetPassword = 40;
      spacingHeadTitle = 33;
      spacingSubTitle = 83;
      spacingTextBox = 100;
      spacingButton = 27.58;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: spacingHeadTitle,
          ),
          Text(ForgotPassword.titleResetPassword,
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontSize: sizeTitleResetPassword,
                  color: AppColors.fieldText)),
          SizedBox(
            height: spacingSubTitle,
          ),
          Text(ForgotPassword.subtitleResetPassword,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontSize: 15)),
          SizedBox(
            height: spacingTextBox,
          ),
          Text(
            ForgotPassword.emailAddress,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.fieldTitle,
                fontSize: 15),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserEmailSubmitFailure) {
                textEmailError = AppConstants.invalidEmail;
              } else if (state is UserEmailSubmitSuccess) {
                textEmailError = null;
              } else if (state is UserAuthFailure &&
                  state.exception == FirebaseCode.userNotFound.code) {
                textEmailError = ForgotPassword.userNotFound;
              } else if (state is UserResetPasswordSuccess) {
                textEmailError = null;
                Future.delayed(Duration(milliseconds: 200),
                    () => Navigator.of(context).pushNamed('/login'));
              }
              return TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                cursorColor: AppColors.mainTheme,
                decoration: InputDecoration(
                  errorText: textEmailError,
                  contentPadding: EdgeInsets.only(top: 15, bottom: 5),
                  isDense: true,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.mainTheme,
                      width: 2,
                    ),
                  ),
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16.5),
              );
            },
          ),
          SizedBox(
            height: spacingButton,
          ),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.mainTheme,
                  minimumSize: Size(widthSizeScreen, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                context
                    .read<UserBloc>()
                    .add(UserForgotPasswordSubmitted(_email.text));
              },
              child: Text(
                ForgotPassword.buttonSend,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Colors.white),
              )),
        ],
      ),
    );
  }
}

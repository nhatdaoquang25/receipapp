import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums/enums_firebase.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import 'responsive.dart';

class LoginForm extends StatelessWidget {
  final double spaceBetweenItems = 30;
  final double spacingAboveOfTexts = 15;
  final double spacingBelowOfTexts = 5;
  final double buttonHeight = 50;
  final double smallTextSize = 14;
  final double mediumTextSize = 16;
  String _email = '';
  String _password = '';
  String? textEmailError;
  String? textPasswordError;
  @override
  Widget build(BuildContext context) {
    final double spacingBelowOfSubtitle =
        Responsive.isMobile(context) ? 47 : 30;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LoginText.subTitleLogin,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontFamily: AppConstants.fontBasic,
              color: AppColors.subTitle,
              fontSize: smallTextSize),
        ),
        SizedBox(
          height: spacingBelowOfSubtitle,
        ),
        Text(
          LoginText.email,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontFamily: AppConstants.fontBasic,
              color: AppColors.fieldTitle,
              fontSize: smallTextSize),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            _checkLogIn(context, state);
            return TextField(
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              onChanged: (value) => _email = value,
              cursorColor: AppColors.mainTheme,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    top: spacingAboveOfTexts, bottom: spacingBelowOfTexts),
                isDense: true,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.mainTheme,
                    width: 2,
                  ),
                ),
                errorText: textEmailError,
              ),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontFamily: AppConstants.fontBasic,
                  color: AppColors.fieldText,
                  fontSize: mediumTextSize),
            );
          },
        ),
        SizedBox(
          height: spaceBetweenItems,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LoginText.password,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontFamily: AppConstants.fontBasic,
                  color: AppColors.fieldTitle,
                  fontSize: smallTextSize),
            ),
            Flexible(
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed('/forgot-password'),
                child: Text(
                  LoginText.forgotPassword,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontFamily: AppConstants.fontBasic,
                      color: AppColors.subTitle,
                      fontSize: smallTextSize),
                ),
              ),
            ),
          ],
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return TextField(
              obscureText: true,
              obscuringCharacter: '⬤',
              onChanged: (value) => _password = value,
              cursorColor: AppColors.mainTheme,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    top: spacingAboveOfTexts, bottom: spacingBelowOfTexts),
                isDense: true,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.mainTheme,
                    width: 2,
                  ),
                ),
                errorText: textPasswordError,
              ),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontFamily: AppConstants.fontBasic,
                    color: AppColors.fieldText,
                    fontSize: mediumTextSize,
                    letterSpacing: 1.5,
                  ),
            );
          },
        ),
        SizedBox(
          height: spaceBetweenItems,
        ),
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.mainTheme),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
            ),
            onPressed: () => _email.isNotEmpty
                ? context
                    .read<UserBloc>()
                    .add(UserLoginButtonSubmitted(_email.trim(), _password))
                : null,
            child: Text(
              LoginText.buttonLogin,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontFamily: AppConstants.fontBasic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: mediumTextSize,
                  ),
            ),
          ),
        ),
        SizedBox(
          height: spaceBetweenItems,
        ),
        Center(
          child: Column(
            children: [
              Text(
                LoginText.subTitleSignUp,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontFamily: AppConstants.fontBasic,
                      color: AppColors.bottomTitle,
                      fontSize: smallTextSize,
                    ),
              ),
              SizedBox(
                height: spacingBelowOfTexts,
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed('/sign-up'),
                child: Text(
                  LoginText.signUpAccount,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontFamily: AppConstants.fontBasic,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainTheme,
                        fontSize: mediumTextSize,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _checkLogIn(BuildContext context, UserState state) {
    switch (state.runtimeType) {
      case UserEmailSubmitFailure:
        textEmailError = null;
        textPasswordError = null;
        textEmailError = AppConstants.invalidEmail;
        break;
      case UserEmailSubmitSuccess:
        textEmailError = null;
        textPasswordError = null;
        break;
      case UserAuthFailure:
        state as UserAuthFailure;
        textEmailError = null;
        textPasswordError = null;
        if (state.exception == FirebaseCode.userNotFound.code) {
          textEmailError = LoginText.accountNotFound;
        } else if (state.exception == FirebaseCode.userWrongPassword.code) {
          textPasswordError = LoginText.incorrectPassword;
        }
        break;
      case UserLoginSuccess:
        textEmailError = null;
        textPasswordError = null;
        Future.delayed(Duration(milliseconds: 200),
            () => Navigator.of(context).pushNamed('/create-recipe'));
        break;
    }
  }
}

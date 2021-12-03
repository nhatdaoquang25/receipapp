import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enums/enums_firebase.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../constants/constants_color.dart';
import '../constants/constants_text.dart';
import 'responsive.dart';

class SignUpForm extends StatelessWidget {
  String _email = '';
  String _password = '';
  String _fullName = '';
  dynamic textEmailError;
  dynamic textPasswordError;
  dynamic textFullNameError;
  final double spacingTextAndTextField = 30;
  @override
  Widget build(BuildContext context) {
    final EdgeInsets paddingSignupForm = Responsive.isTablet(context)
        ? EdgeInsets.all(50)
        : EdgeInsets.fromLTRB(25, 20, 25, 0);
    final double spacingSignupForm = Responsive.isTablet(context) ? 25 : 30;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        _checkSignUp(context, state);
        return Padding(
            padding: paddingSignupForm,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(SignUpText.subTitleCreateAccount,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontFamily: AppConstants.fontBasic,
                            color: AppColors.subTitle,
                            fontSize: 14,
                          )),
                  SizedBox(
                    height: spacingTextAndTextField,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SignUpText.fullName,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontFamily: AppConstants.fontBasic,
                            color: AppColors.fieldTitle,
                            fontSize: 14),
                      ),
                      TextField(
                        cursorColor: AppColors.mainTheme,
                        onChanged: (value) => _fullName = value,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainTheme,
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(top: 15, bottom: 5),
                            isDense: true,
                            errorText: textFullNameError),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontFamily: AppConstants.fontBasic,
                            color: AppColors.appTitle,
                            fontSize: 16),
                      ),
                      SizedBox(height: spacingSignupForm),
                      Text(SignUpText.email,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontFamily: AppConstants.fontBasic,
                                  color: AppColors.fieldTitle,
                                  fontSize: 14)),
                      TextField(
                        cursorColor: AppColors.mainTheme,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => _email = value,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainTheme,
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(top: 15, bottom: 5),
                            isDense: true,
                            errorText: textEmailError),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontFamily: AppConstants.fontBasic,
                            color: AppColors.appTitle,
                            fontSize: 16),
                      ),
                      SizedBox(height: spacingSignupForm),
                      Text(SignUpText.password,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontFamily: AppConstants.fontBasic,
                                  color: AppColors.fieldTitle,
                                  fontSize: 14)),
                      TextField(
                        cursorColor: AppColors.mainTheme,
                        obscureText: true,
                        onChanged: (value) => _password = value,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainTheme,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(top: 15, bottom: 5),
                          isDense: true,
                          errorText: textPasswordError,
                        ),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontFamily: AppConstants.fontBasic,
                            color: AppColors.appTitle,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: spacingSignupForm),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.mainTheme),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                      ),
                      onPressed: () => checkErrSignUp(context),
                      child: Text(
                        SignUpText.buttonCreateAccount,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontFamily: AppConstants.fontBasic,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: spacingTextAndTextField,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          SignUpText.subtitleAlrHaveAcc,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontFamily: AppConstants.fontBasic,
                                    color: AppColors.fieldTitle,
                                    fontSize: 14,
                                  ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () =>
                              {Navigator.of(context).pushNamed('/login')},
                          child: Text(
                            SignUpText.subtitleLoginHere,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontFamily: AppConstants.fontBold,
                                      color: AppColors.mainTheme,
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _checkSignUp(BuildContext context, UserState state) {
    switch (state.runtimeType) {
      case UserFullNameSubmitFailure:
        textFullNameError = SignUpText.invalidFullName;
        textPasswordError = null;
        textEmailError = null;
        break;
      case UserEmailSubmitFailure:
        textEmailError = AppConstants.invalidEmail;
        textFullNameError = null;
        textPasswordError = null;
        break;
      case UserPasswordSubmitFailure:
        textPasswordError = SignUpText.invalidPassword;
        textEmailError = null;
        textFullNameError = null;
        break;
      case UserAuthFailure:
        state as UserAuthFailure;
        if (state.exception == FirebaseCode.userAlreadyExists.code) {
          textEmailError = SignUpText.existAccount;
          textFullNameError = null;
          textPasswordError = null;
        }
        break;
      case UserSignUpSuccess:
        textEmailError = null;
        textPasswordError = null;
        textFullNameError = null;
        Future.delayed(Duration(milliseconds: 200),
            () => Navigator.of(context).pushNamed('/login'));
        break;
    }
  }

  void checkErrSignUp(BuildContext context) {
    context
        .read<UserBloc>()
        .add(UserSignupButtonSubmitted(_email.trim(), _password, _fullName));
  }
}

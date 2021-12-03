import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/enums_firebase.dart';
import '../../services/user_service.dart';
import '../../utils/validators.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  UserBloc({required this.userService}) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    switch (event.runtimeType) {
      case UserSignupButtonSubmitted:
        event as UserSignupButtonSubmitted;
        yield UserLoading();
        if (Validators.isValidEmail(event.email) &&
            Validators.isValidPassword(event.password) &&
            (event.fullName.isNotEmpty && event.fullName.trim().length >= 2)) {
          final status = await userService.signUp(event.email, event.password);
          if (status == FirebaseCode.signUpSuccess.code) {
            yield UserSignUpSuccess();
          } else {
            yield UserAuthFailure(status);
          }
        } else if (event.fullName.trim().length < 2) {
          yield UserFullNameSubmitFailure();
        } else if (!Validators.isValidEmail(event.email)) {
          yield UserEmailSubmitFailure();
        } else if (!Validators.isValidPassword(event.password)) {
          yield UserPasswordSubmitFailure();
        }
        break;
      case UserForgotPasswordSubmitted:
        event as UserForgotPasswordSubmitted;
        yield UserLoading();
        if (Validators.isValidEmail(event.email)) {
          final status = await userService.resetPassword(event.email);
          if (status == FirebaseCode.resetPasswordRequested.code) {
            yield UserResetPasswordSuccess();
          } else {
            yield UserAuthFailure(status);
          }
        } else if (!Validators.isValidEmail(event.email)) {
          yield UserEmailSubmitFailure();
        }
        break;
      case UserLoginButtonSubmitted:
        event as UserLoginButtonSubmitted;
        yield UserLoading();
        if (event.password.isNotEmpty && Validators.isValidEmail(event.email)) {
          final status = await userService.signIn(event.email, event.password);
          if (status == FirebaseCode.loginSuccess.code) {
            yield UserLoginSuccess();
          } else {
            yield UserAuthFailure(status);
          }
        } else if (!Validators.isValidEmail(event.email)) {
          yield UserEmailSubmitFailure();
        } else {
          yield UserEmailSubmitSuccess();
        }
        break;
    }
  }
}

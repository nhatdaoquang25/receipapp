import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/src/blocs/user/user_bloc.dart';
import 'package:mobile_app/src/blocs/user/user_event.dart';
import 'package:mobile_app/src/blocs/user/user_state.dart';
import 'package:mobile_app/src/services/user_service.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../mock/mock_user_service.dart';

void main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();

  UserService userService;
  UserBloc? userBloc;
  setUp(() {
    userService = MockUserService();
    userBloc = UserBloc(userService: userService);
  });
  tearDown(() {
    userBloc?.close();
  });

  blocTest('emits [] when no event is added',
      build: () {
        userService = MockUserService();
        return UserBloc(userService: userService);
      },
      expect: () => []);

  blocTest(
    'emits [UserLoading] then [UserFullNameSubmitFailure] when [UserSignupButtonSubmitted] is called with null data.',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserSignupButtonSubmitted('quang@gmail.com', 'password', '')),
    expect: () => [
      UserLoading(),
      UserFullNameSubmitFailure(),
    ],
  );
  blocTest(
    'emits [UserLoading] then [UserEmailSubmitFailure] when [UserSignupButtonSubmitted] is called with invalid email.',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserSignupButtonSubmitted('', 'Duongvanquang1@', 'quang')),
    expect: () => [
      UserLoading(),
      UserEmailSubmitFailure(),
    ],
  );
  blocTest(
    'emits [UserLoading] then [UserPasswordSubmitFailure] when [UserSignupButtonSubmitted] is called with invalid password.',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserSignupButtonSubmitted('quang@gmail.com', '', 'quang')),
    expect: () => [
      UserLoading(),
      UserPasswordSubmitFailure(),
    ],
  );
  blocTest(
    'emits [UserLoading] then [UserAuthFailure] with invalid email data when [UserSignupButtonSubmitted] is called',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) {
      bloc.add(UserSignupButtonSubmitted(
          'quang@gmail.com', 'Duongvanquang1@', 'quang'));
    },
    expect: () => [UserLoading(), UserAuthFailure('email-already-in-use')],
  );

  blocTest(
      'emits [UserLoading] then [UserSignUpSuccess] when [UserSignupButtonSubmitted] is called with valid data.',
      build: () {
        userService = MockUserService();
        return UserBloc(userService: userService);
      },
      act: (UserBloc bloc) => bloc.add(UserSignupButtonSubmitted(
          'quang235@gmail.com', 'Duongvanquang1@', 'quang')),
      expect: () => [UserLoading(), UserSignUpSuccess()]);
  blocTest(
    'emits [UserLoading] then [UserEmailSubmitSuccess] when [UserLoginButtonSubmitted] is called with a valid email.',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserLoginButtonSubmitted('user@gmail.com', '')),
    expect: () => [
      UserLoading(),
      UserEmailSubmitSuccess(),
    ],
  );
  blocTest(
    'emits [UserLoading] then [UserEmailSubmitFailure] when [UserLoginButtonSubmitted] is called with an invalid email.',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserLoginButtonSubmitted('username', '12345678')),
    expect: () => [
      UserLoading(),
      UserEmailSubmitFailure(),
    ],
  );
  blocTest(
    'emits [UserLoading] then [UserAuthFailure] when [UserLoginButtonSubmitted] is called with an invalid email.',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserLoginButtonSubmitted('user@email.com', '12345678')),
    expect: () => [
      UserLoading(),
      UserAuthFailure('user-not-found'),
    ],
  );
  blocTest(
    'emits [UserLoading] then [UserAuthFailure] when [UserLoginButtonSubmitted] is called with a wrong password.',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserLoginButtonSubmitted('username@email.com', '12345678')),
    expect: () => [
      UserLoading(),
      UserAuthFailure('wrong-password'),
    ],
  );
  blocTest(
    'emits [UserLoading] then [UserLoginSuccess] when [UserLoginButtonSubmitted] is called with valid data.',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserLoginButtonSubmitted('username@email.com', 'Aliba@123')),
    expect: () => [
      UserLoading(),
      UserLoginSuccess(),
    ],
  );
  blocTest(
    'emits [UserLoading] then [UserForgotPasswordSuccess] with invalid email data when [UserForgotPasswordSubmitted] is called',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) {
      bloc.add(UserForgotPasswordSubmitted('bao.tdk2369@gmail.com'));
    },
    expect: () => [UserLoading(), UserResetPasswordSuccess()],
  );
  blocTest(
    'emits [UserLoading] then [UserAuthFailure] with invalid email data when [UserForgotPasswordSubmitted] is called',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) {
      bloc.add(UserForgotPasswordSubmitted('test1246@gmail.com'));
    },
    expect: () => [UserLoading(), UserAuthFailure('user-not-found')],
  );
  blocTest(
    'emits [UserLoading] then [UserEmailSubmitFailure] with invalid email data when [UserForgotPasswordSubmitted] is called',
    build: () {
      userService = MockUserService();
      return UserBloc(userService: userService);
    },
    act: (UserBloc bloc) =>
        bloc.add(UserForgotPasswordSubmitted('bao.tdk2369@')),
    expect: () => [
      UserLoading(),
      UserEmailSubmitFailure(),
    ],
  );
}

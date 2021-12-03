import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/user/user_bloc.dart';
import 'package:mobile_app/src/blocs/user/user_state.dart';
import 'package:mobile_app/src/services/user_service.dart';
import 'package:mobile_app/src/widgets/login_form.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/router_help.dart' as setRoute;
import '../../mock/mock_user_service.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

main() async {
  setUpFirebaseAuthMocks();
  setUp(() => {registerFallbackValue(MyFakeType())});
  await Firebase.initializeApp();
  UserService userService = MockUserService();
  final mockObserver = MockNavigatorObserver();
  final userBloc = UserBloc(userService: userService);
  final widget = MultiBlocProvider(
    providers: [
      BlocProvider.value(value: userBloc),
    ],
    child: MaterialApp(
      home: Scaffold(
        body: LoginForm(),
      ),
      onGenerateRoute: setRoute.Router.generateRoute,
      navigatorObservers: [mockObserver],
    ),
  );

  testWidgets('Should render login form widgets', (tester) async {
    await tester.pumpWidget(widget);
    final subTitleFinder = find.text('Please login to continue.');
    final emailLabelFinder = find.text('Email address');
    final emailTextFieldFinder = find.byType(TextField).first;
    final passwordLabelFinder = find.text('Password');
    final forgotPasswordInkWellFinder =
        find.widgetWithText(InkWell, 'Forgot password?');
    final passwordTextFieldFinder = find.byType(TextField).last;
    final loginTextButtonFinder = find.widgetWithText(TextButton, 'Login');
    final signUpSubtitleFinder = find.text('New to Scratch?');
    final createAnAccountInkWellFinder =
        find.widgetWithText(InkWell, 'Create Account Here');
    expect(subTitleFinder, findsOneWidget);
    expect(emailLabelFinder, findsOneWidget);
    expect(emailTextFieldFinder, findsOneWidget);
    expect(passwordLabelFinder, findsOneWidget);
    expect(forgotPasswordInkWellFinder, findsOneWidget);
    expect(passwordTextFieldFinder, findsOneWidget);
    expect(loginTextButtonFinder, findsOneWidget);
    expect(signUpSubtitleFinder, findsOneWidget);
    expect(createAnAccountInkWellFinder, findsOneWidget);
  });
  testWidgets('Check tapping forgot password inkwell', (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.widgetWithText(InkWell, 'Forgot password?'));
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Check tapping create account inkwell', (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.widgetWithText(InkWell, 'Create Account Here'));
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('invalid email, show error text', (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).first, 'username');
    expect(find.text('username'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Login'));
    userBloc.emit(UserEmailSubmitFailure());
    await tester.pumpAndSettle();
    expect(find.text('Invalid email'), findsOneWidget);
  });
  testWidgets(
      'valid email and password but does not exists on firebase, show error text',
      (tester) async {
    final exception = FirebaseAuthException(code: 'user-not-found');
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).first, 'user@email.com');
    expect(find.text('user@email.com'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, '123456');
    expect(find.text('123456'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Login'));
    userBloc.emit(UserAuthFailure(exception.code));
    await tester.pumpAndSettle();
    expect(find.text('Account does not exists'), findsOneWidget);
  });
  testWidgets(
      'valid email and password but password incorrect on firebase, show error text',
      (tester) async {
    final exception = FirebaseAuthException(code: 'wrong-password');
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).first, 'khang@email.com');
    expect(find.text('khang@email.com'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, '123456');
    expect(find.text('123456'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Login'));
    userBloc.emit(UserAuthFailure(exception.code));
    await tester.pumpAndSettle();
    expect(find.text('Incorrect password'), findsOneWidget);
  });
  testWidgets('valid email and password, navigate to home screen',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).first, 'khang@email.com');
    expect(find.text('khang@email.com'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, 'Aliba@123');
    expect(find.text('Aliba@123'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Login'));
    userBloc.emit(UserLoginSuccess());
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
}

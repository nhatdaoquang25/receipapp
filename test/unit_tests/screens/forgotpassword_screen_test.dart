import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/user/user_bloc.dart';
import 'package:mobile_app/src/blocs/user/user_state.dart';
import 'package:mobile_app/src/screens/forgotpassword_screen.dart';
import 'package:mobile_app/src/services/user_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile_app/src/widgets/logo.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/router_help.dart' as setRoute;
import '../../mock/mock_user_service.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();
  NavigatorObserver mockObserver = MockNavigatorObserver();
  UserService userService = MockUserService();
  final UserBloc bloc = UserBloc(userService: userService);
  setUp(() {
    registerFallbackValue(MyFakeType());
  });

  final widget = MaterialApp(
    home: BlocProvider.value(
      value: bloc,
      child: ForgotPasswordScreen(),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );

  group('Mobile onboarding screen', () {
    testWidgets(
        'Should render widget [Logo], widget [ResetPasswordBox] and title "Reset password" when pump widget [ForgotPasswordScreen]',
        (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(360, 640);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      final nameApp = find.byType(Logo);
      final widgetResetPasswordForm = find.byType(ResetPasswordBox);
      final titleResetPassword = find.text('Reset password');

      expect(nameApp, findsOneWidget);
      expect(widgetResetPasswordForm, findsOneWidget);
      expect(titleResetPassword, findsOneWidget);
    });
  });

  group('Tablet onboarding screen', () {
    testWidgets(
        'Should render widget [Logo], title, widget [ResetPasswordBox] ',
        (tester) async {
      await tester.pumpWidget(widget);
      final nameApp = find.byType(Logo);
      final titleApp = find.text("Start from Sratch");
      final widgetResetPasswordBox = find.byType(ResetPasswordBox);
      expect(nameApp, findsOneWidget);
      expect(titleApp, findsOneWidget);
      expect(widgetResetPasswordBox, findsOneWidget);
    });
  });
  group('Check status when send data to firebase', () {
    testWidgets(
        'Enter invalid data and clicked button "Send", its should render text error Invalid Email',
        (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), "bao.tdk2369");
      expect(find.text('bao.tdk2369'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, "Send"));
      bloc.emit(UserEmailSubmitFailure());
      await tester.pumpAndSettle();
      expect(find.text('Invalid email'), findsOneWidget);
    });
    testWidgets(
        'Enter valid data, but email not register yet and clicked button "Send", its should render text error user not exits',
        (tester) async {
      final exception = 'user-not-found';
      tester.binding.window.physicalSizeTestValue = Size(768, 1024);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), "baotest123456@gmail.com");
      expect(find.text('baotest123456@gmail.com'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, "Send"));
      bloc.emit(UserAuthFailure(exception));
      await tester.pumpAndSettle();
      expect(find.text('User not exits, please check your email again.'),
          findsOneWidget);
    });
    testWidgets(
        'Enter text field valid data and clicked button "Send" , after that navigator to login screen',
        (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), "bao.tdk2369@gmail.com");
      expect(find.text('bao.tdk2369@gmail.com'), findsOneWidget);
      await tester.tap(find.widgetWithText(TextButton, "Send"));
      await tester.pumpAndSettle();
      verify(() => mockObserver.didPush(any(), any()));
    });
  });
}

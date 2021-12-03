import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/user/user_bloc.dart';
import 'package:mobile_app/src/blocs/user/user_state.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';
import 'package:mobile_app/src/services/user_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/router_help.dart' as setRoute;
import '../../mock/mock_user_service.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() async {
  NavigatorObserver mockObserver = MockNavigatorObserver();
  UserService userService = MockUserService();
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();

  final bloc = UserBloc(userService: userService);
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: BlocProvider.value(
      value: bloc,
      child: SignUpScreen(),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );

  testWidgets(
      'Should render text [Email],[Password],[Full Name] and [Create account to continue.]',
      (tester) async {
    await tester.pumpWidget(widget);
    final textFullName = find.text('Full Name');
    final textEmail = find.text('Email');
    final textPasword = find.text('Password');
    final textCreateaccount = find.text('Create account to continue.');
    expect(textFullName, findsOneWidget);
    expect(textEmail, findsOneWidget);
    expect(textPasword, findsOneWidget);
    expect(textCreateaccount, findsOneWidget);
  });
  testWidgets('Should render textfield  [Email],[Password],[Full Name]',
      (tester) async {
    await tester.pumpWidget(widget);
    final textfieldTabletFullName = find.byType(TextField).first;
    final textfieldEmailTablet = find.byType(TextField).last;
    final textfieldPasswordTablet = find.byType(TextField).last;
    expect(textfieldTabletFullName, findsOneWidget);
    expect(textfieldEmailTablet, findsOneWidget);
    expect(textfieldPasswordTablet, findsOneWidget);
  });
  testWidgets('Clicked on the screen and should move to login screen ',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.tap(find.widgetWithText(InkWell, 'Login Here'));
    await tester.pump();
    verify(() => mockObserver.didPush(any(), any()));
  });

  testWidgets(
      'Enter text field valid data and clicked button "Create Account" , after that navigator to login screen',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).last, "quang@gmail.com");
    expect(find.text('quang@gmail.com'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, "Create Account"));
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Clicked button "Create Account" when Email is already in use',
      (tester) async {
    final exception = 'email-already-in-use';
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).first, "quang");
    expect(find.text('quang'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, "quang@gmail.com");
    expect(find.text('quang@gmail.com'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, "Duongvanquang1@");
    expect(find.text('Duongvanquang1@'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, "Create Account"));
    bloc.emit(UserAuthFailure(exception));
    await tester.pumpAndSettle();
    expect(find.text('Account already exists. Please change guest account'),
        findsOneWidget);
  });
  testWidgets(
      'Enter incorrect full name or less than 2 characters, show error text',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).first, '1');
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Create Account'));
    bloc.emit(UserFullNameSubmitFailure());
    await tester.pumpAndSettle();
    expect(find.text('Full name at least 2 characters'), findsOneWidget);
  });
  testWidgets('invalid email, show error text', (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).first, 'hai');
    await tester.enterText(find.byType(TextField).last, 'quang');
    expect(find.text('hai'), findsOneWidget);
    expect(find.text('quang'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Create Account'));
    bloc.emit(UserEmailSubmitFailure());
    await tester.pumpAndSettle();
    expect(find.text('Invalid email'), findsOneWidget);
  });
  testWidgets('password is wrong when button , show error text',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).last, 'Duongvanquang');
    expect(find.text('Duongvanquang'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Create Account'));
    bloc.emit(UserEmailSubmitSuccess());
    bloc.emit(UserPasswordSubmitFailure());
    await tester.pumpAndSettle();
    expect(
        find.text(
            'Password should have more than 8 characters,\nincluding number, lower and upper character,\nand special symbol.'),
        findsOneWidget);
  });
  testWidgets('full name, valid email and password, navigate to home screen',
      (tester) async {
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextField).first, "quang");
    expect(find.text('quang'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, "quang@gmail.com");
    expect(find.text('quang@gmail.com'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, "Duongvanquang1@");
    expect(find.text('Duongvanquang1@'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, "Create Account"));
    bloc.emit(UserSignUpSuccess());
    await tester.pumpAndSettle();
    verify(() => mockObserver.didPush(any(), any()));
  });
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/user/user_bloc.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';
import 'package:mobile_app/src/services/user_service.dart';
import 'package:mobile_app/src/widgets/signup_form.dart';
import 'package:mobile_app/src/widgets/logo.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../mock/mock_user_service.dart';

main() async {
  setUpFirebaseAuthMocks();
  await Firebase.initializeApp();
  UserService userService = MockUserService();
  final userBloc = UserBloc(userService: userService);
  final widget = MaterialApp(
    home: MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: userBloc,
        ),
      ],
      child: SignUpScreen(),
    ),
  );

  testWidgets('Should render mobile signup screen widgets', (tester) async {
    tester.binding.window.physicalSizeTestValue = Size(400, 720);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(widget);
    final imageFinder =
        tester.widgetList<Image>(find.byType(Image)).first.image as AssetImage;
    final titleFinder = find.text('Start \nfrom Scratch');
    final logoFinder = find.byType(Logo);
    final signUpFormFinder = find.byType(SignUpForm);
    expect(imageFinder.assetName, 'assets/images/cover.png');
    expect(titleFinder, findsOneWidget);
    expect(logoFinder, findsOneWidget);
    expect(signUpFormFinder, findsOneWidget);
  });
  testWidgets('Should render tablet signup screen widgets', (tester) async {
    await tester.pumpWidget(widget);
    final backgroundImageFinder =
        tester.widgetList<Image>(find.byType(Image)).first.image as AssetImage;
    final titleFinder = find.text('Start from Scratch');
    final logoFinder = find.byType(Logo);
    final signUpFormFinder = find.byType(SignUpForm);
    expect(backgroundImageFinder.assetName,
        'assets/images/welcome_background.jpeg');
    expect(titleFinder, findsOneWidget);
    expect(logoFinder, findsOneWidget);
    expect(signUpFormFinder, findsOneWidget);
  });
}

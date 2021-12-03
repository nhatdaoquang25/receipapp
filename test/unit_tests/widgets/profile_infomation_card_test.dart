import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/user_profile.dart';
import 'package:mobile_app/src/widgets/profile_infomation_card.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/firebase_cloud.dart';
import '../../handler_test/network_image.dart';
import '../../handler_test/router_help.dart' as setRoute;

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

main() async {

  setUpFirebaseAuthMocks();
  setUp(() {
    registerFallbackValue(MyFakeType());
  });
  await Firebase.initializeApp();
  final mockObserver = MockNavigatorObserver();


  final widget = MaterialApp(
    home: Scaffold(
      body: ProfileInfomationCard()
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );

  testWidgets('Should render element in ProfileInfomationCard ',
      (WidgetTester tester) async {
         await mockNetworkImages(() async {  
    await tester.pumpWidget(widget);
    final infomationCard = find.byType(ListView);
    expect(infomationCard, findsOneWidget);
    final divider = find.byType(Divider);
    expect(divider, findsOneWidget);
    
      });
  });
  
  testWidgets('Should render edit icon', (WidgetTester tester) async {
    final Image imageWidget = Image.asset('assets/icons/edit.png');
    assert(imageWidget.image is AssetImage);
    final AssetImage assetImage = imageWidget.image as AssetImage;
    expect(assetImage.keyName, 'assets/icons/edit.png');
  });

  testWidgets('Should render texts in ProfileInfomationCard ',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {      
      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 3));
      final nameUser = find.descendant(
          of: find.byType(ProfileInfomationCard),
          matching: find.text(user.name));
      expect(nameUser, findsOneWidget);
      final nickNameUser = find.descendant(
          of: find.byType(ProfileInfomationCard),
          matching: find.text(user.nickName));
      expect(nickNameUser, findsOneWidget);
      final follow = find.descendant(
          of: find.byType(ProfileInfomationCard),
          matching: find.text("${user.follow} followers"));
      expect(follow, findsOneWidget);
      final like = find.descendant(
          of: find.byType(ProfileInfomationCard),
          matching: find.text("${user.like} likes"));
      expect(like, findsOneWidget);
    });
  });
}





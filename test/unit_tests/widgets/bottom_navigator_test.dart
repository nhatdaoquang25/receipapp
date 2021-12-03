import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/user/user_bloc.dart';
import 'package:mobile_app/src/services/user_service.dart';
import 'package:mobile_app/src/widgets/bottom_navigator.dart';
import 'package:mocktail/mocktail.dart';

import '../../handler_test/router_help.dart' as setRoute;
import '../../mock/mock_user_service.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() async {
  NavigatorObserver mockObserver = MockNavigatorObserver();
  UserService userService = MockUserService();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final bloc = UserBloc(userService: userService);
  final widget = MaterialApp(
    home: BlocProvider.value(
      value: bloc,
      child: BottomNavigator(),
    ),
    onGenerateRoute: setRoute.Router.generateRoute,
    navigatorObservers: [mockObserver],
  );
  testWidgets('Should render  icon image bottomtab search', (tester) async {
    await tester.pumpWidget(widget);
    final AssetImage imageSearch = AssetImage(
      'assets/icons/search_icon.png',
    );
    final List<Image> searchImageFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(searchImageFinder[0].image, imageSearch);

    await tester.tap(find.byType(Image).first);
    await tester.pump();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Show render icon iamge bottomtab user profile', (tester) async {
    await tester.pumpWidget(widget);
    final AssetImage imageprofile = AssetImage(
      'assets/icons/recipe_icon.png',
    );
    final profileImageFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(profileImageFinder[1].image, imageprofile);
    await tester.tap(find.byType(Image).last);
    await tester.pump();
    verify(() => mockObserver.didPush(any(), any()));
  });
  testWidgets('Show render icon image bottomtab recipe', (tester) async {
    await tester.pumpWidget(widget);
    final AssetImage imagerecipe = AssetImage(
      'assets/icons/user_profile_icon.png',
    );
    final recipeImageFinder =
        tester.widgetList<Image>(find.byType(Image)).toList();
    expect(recipeImageFinder[2].image, imagerecipe);
    await tester.tap(find.byType(Image).last);
    await tester.pump();
    verify(() => mockObserver.didPush(any(), any()));
  });
}

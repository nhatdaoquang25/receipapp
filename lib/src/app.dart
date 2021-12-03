import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/user/user_bloc.dart';
import 'blocs/feed/feed_card_bloc.dart';
import 'blocs/recipe/recipe_bloc.dart';
import 'blocs/create_recipe/create_recipe_bloc.dart';
import 'screens/feed_screen.dart';
import 'screens/forgotpassword_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/create_recipe_screen.dart';
import 'screens/search_screen.dart';
import 'services/user_service.dart';
import 'services/feed_card_service.dart';
import 'services/search_service.dart';
import 'services/create_recipe_service.dart';
import 'constants/constants_text.dart';
import 'widgets/bottom_navigator.dart';

class App extends StatelessWidget {
  final UserService _userService = UserService();
  final FeedCardService _feedCardService = FeedCardService();
  final RecipeService _recipeService = RecipeService();
  final Connectivity _connect = Connectivity();
  final CreateRecipeService _createRecipeService = CreateRecipeService();
  late final UserBloc _userBloc;
  late final FeedCardBloc _feedCardBloc;
  late final RecipeBloc _recipeBloc;
  late final CreateRecipeBloc _createRecipeBloc;
  @override
  Widget build(BuildContext context) {
    _userBloc = UserBloc(userService: _userService);
    _feedCardBloc =
        FeedCardBloc(feedCardService: _feedCardService, connect: _connect);

    _recipeBloc = RecipeBloc(recipeService: _recipeService);
    _createRecipeBloc =
        CreateRecipeBloc(createRecipeService: _createRecipeService);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _userBloc,
        ),
        BlocProvider.value(
          value: _feedCardBloc,
        ),
        BlocProvider.value(
          value: _recipeBloc,
        ),
        BlocProvider.value(
          value: _createRecipeBloc,
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: AppConstants.fontRegular),
        routes: {
          '/login': (context) => LoginScreen(),
          '/sign-up': (context) => SignUpScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          '/feed': (context) => FeedScreen(),
          '/search': (context) => SearchScreen(),
          '/create-recipe': (context) => CreateRecipeScreen(),
          '/': (context) => OnboardingScreen(),
          '/navigation': (context) => BottomNavigator(),
        },
      ),
    );
  }
}

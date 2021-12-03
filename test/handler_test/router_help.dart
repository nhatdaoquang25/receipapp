import 'package:flutter/material.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';

const String onboardingRoute = '/';
const String loginRoute = '/login';
const String signupRoute = '/sign-up';
const String forgotpasswordRoute = '/forgot-password';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signupRoute:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:itc/screens/home.dart';
import 'package:itc/screens/onboarding/onboarding.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F8FA),
        colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: Color(0xFF123B7A),
          //onPrimary: onPrimary,
          secondary: Color(0xFFE13B2E),
          //onSecondary: onSecondary,
          error: Colors.red,
          //onError: onError,
          surface:  Color(0xFFF5F8FA),
          //onSurface: onSurface
        )
    ),
    initialRoute: '/onboarding',
    routes: {
      '/': (context) => Home(),
      '/onboarding': (context) => OnboardingScreen(),
      // '/map': (context) => Map(),
      // '/preferences': (context) => Preferences(),
    },

  ));
}


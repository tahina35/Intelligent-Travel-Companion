import 'package:flutter/material.dart';
import 'package:itc/screens/home.dart';
import 'package:itc/screens/preferences.dart';
import 'package:itc/screens/map.dart';
import 'package:itc/screens/onboarding/onboarding.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/onboarding',
    routes: {
      '/': (context) => Home(),
      '/onboarding': (context) => OnboardingScreen(),
      // '/map': (context) => Map(),
      // '/preferences': (context) => Preferences(),
    },
  ));
}


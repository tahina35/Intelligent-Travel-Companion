import 'package:flutter/material.dart';
import 'package:itc/screens/home.dart';
import 'package:itc/screens/preferences.dart';
import 'package:itc/screens/map.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      // '/map': (context) => Map(),
      // '/preferences': (context) => Preferences(),
    },
  ));
}


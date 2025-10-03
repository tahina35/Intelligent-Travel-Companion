import 'package:flutter/material.dart';
import 'package:itc/router/app_router.dart';

void main() {
  runApp(MaterialApp.router(
    theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: Color(0xFF0A66C2),
          //onPrimary: onPrimary,
          secondary: Colors.transparent,
          //onSecondary: onSecondary,
          error: Colors.red,
          //onError: onError,
          surface:  Color(0xFFF5F8FA),
          //onSurface: onSurface
        )
    ),
    routerConfig: AppRouter().router,
  ));
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itc/router/route_constants.dart';
import 'package:itc/screens/onboarding/loading_screen.dart';
import '../screens/home.dart';
import '../screens/onboarding/onboarding.dart';
import '../services/preference_service.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        name: RouteConstants.home,
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: Home(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: animation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          );
        },
        redirect: (context, state) async {
          //final bool isPreferenceSet = await PreferenceService.isPreferenceSet();
          final bool isPreferenceSet = false;
          if (!isPreferenceSet) {
            return state.namedLocation(RouteConstants.onboarding);
          }
          return null;
        },
      ),
      GoRoute(
        name: RouteConstants.onboarding,
        path: '/onboarding',
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        name: RouteConstants.loading,
        path: '/loading',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: LoadingScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),
    ]
  );
}
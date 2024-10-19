import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:psychology_mobile/common/navigation/navigation_service.dart';
import 'package:psychology_mobile/models/quiz_model.dart';
import 'package:psychology_mobile/screens/entry_screen.dart';
import 'package:psychology_mobile/screens/first_screen.dart';
import 'package:psychology_mobile/screens/profile_screen.dart';
import 'package:psychology_mobile/screens/quiz_screen.dart';
import 'package:psychology_mobile/screens/result_screen.dart';
import 'package:psychology_mobile/screens/splash_screen.dart';

class AppGoRouter {
  const AppGoRouter._();

  static final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: SplashScreen.routeName,
    routes: [
      GoRoute(
        path: SplashScreen.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: EntryScreen.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: EntryScreen(),
        ),
      ),
      GoRoute(
        path: FirstScreen.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: FirstScreen(),
        ),
      ),
      GoRoute(
        path: ProfileScreen.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: ProfileScreen(),
        ),
      ),
      GoRoute(
        path: QuizScreen.routeName,
        pageBuilder: (context, state) => const MaterialPage(
          child: QuizScreen(),
        ),
      ),
      GoRoute(
        path: ResultScreen.routeName,
        pageBuilder: (context, state) {
          final extra = state.extra as List<QuizModel>?;
          return MaterialPage(
            child: ResultScreen(quizzes: extra ?? []),
          );
        },
      ),
    ],
  );
}

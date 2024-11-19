import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/routing/routes.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/presentation/pages/add_question_page.dart';
import 'package:portal/features/questions/presentation/pages/home_page.dart';
import 'package:portal/features/questions/presentation/pages/question_details_page.dart';
import 'package:portal/features/submissions/presentation/pages/submissions_page.dart';
import 'package:portal/features/splash_page/splash_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: splashPage,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: homePage,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
          path: addQuestionPage,
          builder: (context, state) {
            final question = state.extra as Question?;
            return AddQuestionPage(
              question: question,
            );
          }),
      GoRoute(
        path: submissionsPage,
        builder: (context, state) => const SubmissionsPage(),
      ),
      GoRoute(
        path: questionDetailsPage,
        builder: (context, state) {
          final question = state.extra as Question;
          return QuestionDetailsPage(
            question: question,
          );
        },
      ),
    ],
    initialLocation: splashPage,
  );
}

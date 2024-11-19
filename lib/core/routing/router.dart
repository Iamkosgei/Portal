import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/routing/routes.dart';
import 'package:portal/features/home_page/domain/entities/question/question.dart';
import 'package:portal/features/home_page/presentation/add_question/add_question_page.dart';
import 'package:portal/features/home_page/presentation/home_page/home_page.dart';
import 'package:portal/features/home_page/presentation/question_details_page/question_details_page.dart';
import 'package:portal/features/home_page/presentation/submissions_page/submissions_page.dart';
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
        builder: (context, state) => const AddQuestionPage(),
      ),
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

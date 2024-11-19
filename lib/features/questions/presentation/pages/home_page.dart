import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/core/service_locator/get_it.dart';
import 'package:portal/features/questions/presentation/bloc/delete_question/delete_question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/question/question_cubit.dart';
import 'package:portal/features/questions/presentation/widgets/home_page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => getIt<QuestionCubit>()..loadQuestions()),
          BlocProvider(create: (context) => getIt<DeleteQuestionCubit>()),
        ],
        child: const HomePageBody(),
      ),
    );
  }
}

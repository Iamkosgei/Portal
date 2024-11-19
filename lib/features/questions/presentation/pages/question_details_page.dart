import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal/core/service_locator/get_it.dart';
import 'package:portal/features/questions/presentation/bloc/question_details/question_details_cubit.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/presentation/widgets/question_details_body.dart';

class QuestionDetailsPage extends StatelessWidget {
  final Question question;

  const QuestionDetailsPage({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuestionDetailsCubit>(),
      child: QuestionDetailsBody(
        question: question,
      ),
    );
  }
}

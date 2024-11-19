import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/core/service_locator/get_it.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_state.dart';
import 'package:portal/features/questions/presentation/widgets/add_question_body.dart';

class AddQuestionPage extends StatelessWidget {
  final Question? question;

  const AddQuestionPage({super.key, this.question});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: BlocProvider(
        create: (context) => getIt<AddQuestionCubit>(),
        child: BlocListener<AddQuestionCubit, AddQuestionState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                context.pop();
                showSuccessSnackBar(
                  context,
                  question != null
                      ? 'Question updated successfully!'
                      : 'Question added successfully!',
                );
              },
              failure: (failure) {
                showErrorSnackBar(
                  context,
                  question != null
                      ? 'Failed to update question. Please try again.'
                      : 'Failed to add question. Please try again.',
                );
              },
            );
          },
          child: AddQuestionBody(
            initialQuestion: question,
          ),
        ),
      ),
    );
  }
}

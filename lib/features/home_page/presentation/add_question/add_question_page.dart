import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/core/service_locator/get_it.dart';
import 'package:portal/features/home_page/application/add_question/add_question_cubit.dart';
import 'package:portal/features/home_page/application/add_question/add_question_state.dart';
import 'package:portal/features/home_page/presentation/add_question/widgets/add_question_body.dart';

class AddQuestionPage extends StatelessWidget {
  const AddQuestionPage({super.key});

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
                showSuccessSnackBar(context, 'Question added successfully!');
              },
              failure: (failure) {
                showErrorSnackBar(
                    context, 'Failed to add question. Please try again.');
              },
            );
          },
          child: const AddQuestionBody(),
        ),
      ),
    );
  }
}

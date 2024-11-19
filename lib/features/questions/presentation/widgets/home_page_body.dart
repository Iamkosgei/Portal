import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/common/string_utils.dart';
import 'package:portal/core/routing/routes.dart';
import 'package:portal/features/questions/presentation/bloc/delete_question/delete_question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/question/question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/question/question_state.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/presentation/widgets/question_card.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Portal",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push(submissionsPage);
            },
            icon: const Icon(
              Icons.history,
            ),
          ),
          IconButton(
            onPressed: () {
              _showFilterBottomSheet(context);
            },
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: BlocListener<DeleteQuestionCubit, bool>(
        listener: (context, state) {
          if (state) {
            context.read<QuestionCubit>().loadQuestions();
          }
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocBuilder<QuestionCubit, QuestionState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: () {
                        context.read<QuestionCubit>().loadQuestions();
                        return Future.value();
                      },
                      child: state.when(
                        initial: () => const SizedBox(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        success: (questions) {
                          return ListView.builder(
                            itemCount: questions.length,
                            itemBuilder: (context, index) {
                              final question = questions[index];
                              return InkWell(
                                  onTap: () {
                                    context.push(
                                      questionDetailsPage,
                                      extra: question,
                                    );
                                  },
                                  child: QuestionCard(
                                    question: question,
                                  ));
                            },
                          );
                        },
                        failure: (e) => Center(
                          child: Text(
                            e.toString(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(addQuestionPage).then(
            (v) {
              context.read<QuestionCubit>().loadQuestions();
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final questionCubit = context.read<QuestionCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: questionCubit,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Filter by Difficulty",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // List of difficulty levels
                Column(
                  children: [
                    ListTile(
                      title: const Text("All Difficulties"),
                      onTap: () {
                        questionCubit.filterQuestions(null);
                        Navigator.pop(context);
                      },
                    ),
                    ...DifficultyLevel.values.map((difficulty) {
                      return ListTile(
                        title: Text(difficulty.name.capitalize()),
                        onTap: () {
                          questionCubit
                              .filterQuestions(difficulty); // Apply filter
                          Navigator.pop(context); // Close bottom sheet
                        },
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

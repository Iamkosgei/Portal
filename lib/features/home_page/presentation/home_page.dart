import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/core/routing/routes.dart';
import 'package:portal/core/service_locator/get_it.dart';
import 'package:portal/features/home_page/application/question/question_cubit.dart';
import 'package:portal/features/home_page/application/question/question_state.dart';
import 'package:portal/features/home_page/domain/entities/question/question.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: BlocProvider(
          create: (context) => getIt<QuestionCubit>()..loadQuestions(),
          child: const HomePageBody()),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

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
            icon: const Icon(Icons.filter_alt_outlined), // Filter icon
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
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
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 32,
                                ),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/card_bg.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    question.questionText,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${question.options.length} choices",
                                  ),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      color: getDifficultyColor(
                                              question.difficulty)
                                          .withOpacity(.08),
                                    ),
                                    child: Text(
                                      question.difficulty.name,
                                      style: TextStyle(
                                        color: getDifficultyColor(
                                            question.difficulty),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(addQuestionPage);
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

  Color getDifficultyColor(DifficultyLevel level) {
    var color = Colors.green;
    switch (level) {
      case DifficultyLevel.easy:
        color = Colors.green;
        break;
      case DifficultyLevel.medium:
        color = Colors.orange;
        break;
      case DifficultyLevel.hard:
        color = Colors.red;
        break;
    }
    return color;
  }
}

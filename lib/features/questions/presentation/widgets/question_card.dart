import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal/core/routing/routes.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/presentation/bloc/delete_question/delete_question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/question/question_cubit.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                color: getDifficultyColor(question.difficulty).withOpacity(.08),
              ),
              child: Text(
                question.difficulty.name,
                style: TextStyle(
                  color: getDifficultyColor(question.difficulty),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmation(context, question.id);
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.push(addQuestionPage, extra: question).then(
                  (v) {
                    context.read<QuestionCubit>().loadQuestions();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, String questionId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Question'),
        content: const Text('Are you sure you want to delete this question?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      if (context.mounted) {
        context.read<DeleteQuestionCubit>().deleteQuestion(questionId);
      }
    }
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

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/features/questions/presentation/bloc/question_details/question_details_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/question_details/question_details_state.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';

class QuestionDetailsBody extends StatefulWidget {
  final Question question;
  const QuestionDetailsBody({super.key, required this.question});

  @override
  State<QuestionDetailsBody> createState() => _QuestionDetailsBodyState();
}

class _QuestionDetailsBodyState extends State<QuestionDetailsBody> {
  String? selectedOptionId;
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: BlocListener<QuestionDetailsCubit, QuestionDetailsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            correct: () {
              showSuccessDialog(context);
            },
            incorrect: () {
              showFailureDialog(context);
            },
          );
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                margin: const EdgeInsets.all(8.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Text(
                    widget.question.difficulty.name.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: getDifficultyColor(widget.question.difficulty),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Question #${widget.question.id}",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      widget.question.questionText,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24.0),
                    // Options
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.question.options.length,
                      itemBuilder: (context, index) {
                        final option = widget.question.options[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8.0),
                          child: RadioListTile<String>(
                            title: Text(option.optionText),
                            value: option.id,
                            groupValue: selectedOptionId,
                            onChanged: (String? value) {
                              setState(() {
                                selectedOptionId = value;
                              });
                            },
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                color: selectedOptionId == option.id
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedOptionId == null) {
                          const snackBar = SnackBar(
                            content: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Please select one option!',
                              ),
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        context
                            .read<QuestionDetailsCubit>()
                            .validateAnswer(widget.question, selectedOptionId!);
                      },
                      child: const Text('Submit'),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  //TODO clean ups
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

  Future<void> showSuccessDialog(BuildContext context) async {
    final player = AudioPlayer();
    await player.play(AssetSource('success_sound.mp3'));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/success_animation.json',
                  height: 150,
                  repeat: false,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Congratulations!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'You answered correctly!',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showFailureDialog(BuildContext context) async {
    final player = AudioPlayer();
    await player.play(AssetSource('failure_sound.mp3'));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/failure_animation.json',
                  height: 150,
                  repeat: false,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Oops!',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                const Text(
                  'That was not the correct answer.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

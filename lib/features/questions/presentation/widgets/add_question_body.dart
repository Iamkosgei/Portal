import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal/core/common/string_utils.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_cubit.dart';
import 'package:portal/features/questions/domain/entities/option/option.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:uuid/uuid.dart';

class AddQuestionBody extends StatefulWidget {
  const AddQuestionBody({super.key});

  @override
  _AddQuestionBodyState createState() => _AddQuestionBodyState();
}

class _AddQuestionBodyState extends State<AddQuestionBody> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _options = <TextEditingController>[];
  int? _correctOptionIndex;
  DifficultyLevel _difficultyLevel = DifficultyLevel.easy;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Start with 4 options by default
    for (int i = 0; i < 4; i++) {
      _addOption();
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _options) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    if (_options.length < 6) {
      _options.add(TextEditingController());
      setState(() {});
    }
  }

  void _removeOption(int index) {
    if (_options.length > 2) {
      if (_correctOptionIndex == index) {
        _correctOptionIndex = null;
      } else if (_correctOptionIndex != null && _correctOptionIndex! > index) {
        _correctOptionIndex = _correctOptionIndex! - 1;
      }
      _options[index].dispose();
      _options.removeAt(index);
      setState(() {});
    }
  }

  Color _getDifficultyColor(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.easy:
        return Colors.green;
      case DifficultyLevel.medium:
        return Colors.orange;
      case DifficultyLevel.hard:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Create New Question',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Question Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _questionController,
                          decoration: InputDecoration(
                            labelText: 'Question Text',
                            hintText: 'Enter your question here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.help_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a question';
                            }
                            return null;
                          },
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Answer Options',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (_options.length < 6)
                              TextButton.icon(
                                onPressed: _addOption,
                                icon: const Icon(Icons.add),
                                label: const Text('Add Option'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _options.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Radio<int>(
                                  value: index,
                                  groupValue: _correctOptionIndex,
                                  onChanged: (value) {
                                    setState(() {
                                      _correctOptionIndex = value;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _options[index],
                                    decoration: InputDecoration(
                                      labelText: 'Option ${index + 1}',
                                      hintText: 'Enter option text',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      suffixIcon: _options.length > 2
                                          ? IconButton(
                                              icon: const Icon(
                                                  Icons.remove_circle),
                                              color: Colors.red,
                                              onPressed: () =>
                                                  _removeOption(index),
                                            )
                                          : null,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an option';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Difficulty Level',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<DifficultyLevel>(
                          value: _difficultyLevel,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: Icon(
                              Icons.speed,
                              color: _getDifficultyColor(_difficultyLevel),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _difficultyLevel = value ?? DifficultyLevel.easy;
                            });
                          },
                          items: DifficultyLevel.values.map((level) {
                            return DropdownMenuItem(
                              value: level,
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: _getDifficultyColor(level),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(level
                                      .toString()
                                      .split('.')
                                      .last
                                      .capitalize()),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isSubmitting
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate() &&
                                _correctOptionIndex != null) {
                              setState(() {
                                _isSubmitting = true;
                              });

                              final questionId = const Uuid().v4();
                              final question = Question(
                                id: questionId,
                                questionText: _questionController.text,
                                difficulty: _difficultyLevel,
                                options: List.generate(
                                  _options.length,
                                  (index) => Option(
                                    id: const Uuid().v4(),
                                    questionId: questionId,
                                    optionText: _options[index].text,
                                    isCorrect: index == _correctOptionIndex,
                                  ),
                                ),
                              );

                              context
                                  .read<AddQuestionCubit>()
                                  .createQuestion(question);
                            } else if (_correctOptionIndex == null) {
                              showErrorSnackBar(
                                context,
                                'Please select the correct answer',
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Save Question',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

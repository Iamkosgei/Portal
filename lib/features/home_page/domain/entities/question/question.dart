import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portal/features/home_page/domain/entities/option/option.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String questionText,
    required DifficultyLevel difficulty,
    required List<Option> options,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}

enum DifficultyLevel { easy, medium, hard }

import 'package:floor/floor.dart';

@entity
class QuestionEntity {
  @primaryKey
  final String id;
  final String questionText;
  final String difficulty;

  QuestionEntity({
    required this.id,
    required this.questionText,
    required this.difficulty,
  });
}

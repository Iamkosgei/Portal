import 'package:floor/floor.dart';
import 'package:portal/features/questions/data/models/question_entity.dart';

@entity
class SubmissionEntity {
  @primaryKey
  final String id;

  @ForeignKey(
    entity: QuestionEntity,
    parentColumns: ['id'],
    childColumns: ['questionId'],
    onDelete: ForeignKeyAction.cascade,
  )
  final String questionId;
  final String question;
  final String submittedAnswer;
  final int totalMarks;
  final String correctAnswer;

  SubmissionEntity({
    required this.id,
    required this.questionId,
    required this.question,
    required this.submittedAnswer,
    required this.totalMarks,
    required this.correctAnswer,
  });
}

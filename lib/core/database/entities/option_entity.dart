import 'package:floor/floor.dart';
import 'package:portal/core/database/entities/question_entity.dart';

@entity
class OptionEntity {
  @primaryKey
  final String id;

  @ForeignKey(
    entity: QuestionEntity,
    parentColumns: ['id'],
    childColumns: ['questionId'],
    onDelete: ForeignKeyAction.cascade,
  )
  final String questionId;
  final String optionText;
  final bool isCorrect;

  OptionEntity({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.isCorrect,
  });
}

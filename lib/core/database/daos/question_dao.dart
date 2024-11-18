import 'package:floor/floor.dart';
import 'package:portal/core/database/entities/question_entity.dart';

@dao
abstract class QuestionDao {
  @Query('SELECT * FROM QuestionEntity')
  Future<List<QuestionEntity>> getAllQuestions();

  @Query('SELECT * FROM QuestionEntity WHERE id = :id')
  Future<QuestionEntity?> getQuestionById(String id);

  @insert
  Future<void> insertQuestion(QuestionEntity question);

  @update
  Future<void> updateQuestion(QuestionEntity question);

  @delete
  Future<void> deleteQuestion(QuestionEntity question);
}

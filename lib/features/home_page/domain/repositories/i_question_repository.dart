import 'package:dartz/dartz.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/home_page/domain/entities/question/question.dart';

abstract class IQuestionRepository {
  Future<Either<QuestionFailure, List<Question>>> getQuestions();
  Future<Either<QuestionFailure, Question>> getQuestionById(String id);
  Future<Either<QuestionFailure, Unit>> createQuestion(Question question);
  Future<Either<QuestionFailure, Unit>> updateQuestion(Question question);
  Future<Either<QuestionFailure, Unit>> deleteQuestion(String id);
}

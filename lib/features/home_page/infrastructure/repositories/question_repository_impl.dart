import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:portal/core/database/database.dart';
import 'package:portal/core/database/mappers/question_mapper.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/home_page/domain/entities/question/question.dart';
import 'package:portal/features/home_page/domain/repositories/i_question_repository.dart';

@Injectable(as: IQuestionRepository)
class QuestionRepositoryImpl implements IQuestionRepository {
  final AppDatabase _database;

  QuestionRepositoryImpl(this._database);

  @override
  Future<Either<QuestionFailure, List<Question>>> getQuestions() async {
    try {
      final questionEntities = await _database.questionDao.getAllQuestions();
      final questions = await Future.wait(
        questionEntities.map((qEntity) async {
          final options =
              await _database.optionDao.getOptionsForQuestion(qEntity.id);
          return QuestionMapper.toDomain(qEntity, options);
        }),
      );
      return right(questions);
    } catch (e) {
      return left(const QuestionFailure.unexpected());
    }
  }

  @override
  Future<Either<QuestionFailure, Unit>> createQuestion(
      Question question) async {
    try {
      //TODOswitch to transactions
      final questionEntity = QuestionMapper.toEntity(question);
      final optionEntities = QuestionMapper.optionsToEntities(question);

      await _database.questionDao.insertQuestion(questionEntity);
      for (final option in optionEntities) {
        await _database.optionDao.insertOption(option);
      }

      return right(unit);
    } catch (e) {
      return left(const QuestionFailure.unexpected());
    }
  }

  @override
  Future<Either<QuestionFailure, Unit>> updateQuestion(
      Question question) async {
    try {
      //TODOswitch to transactions
      final questionEntity = QuestionMapper.toEntity(question);
      final optionEntities = QuestionMapper.optionsToEntities(question);

      await _database.questionDao.updateQuestion(questionEntity);
      // Delete existing options and insert new ones
      final existingOptions =
          await _database.optionDao.getOptionsForQuestion(question.id);
      for (final option in existingOptions) {
        await _database.optionDao.deleteOption(option);
      }
      for (final option in optionEntities) {
        await _database.optionDao.insertOption(option);
      }

      return right(unit);
    } catch (e) {
      return left(const QuestionFailure.unexpected());
    }
  }

  @override
  Future<Either<QuestionFailure, Question>> getQuestionById(String id) async {
    try {
      final questionEntity = await _database.questionDao.getQuestionById(id);
      if (questionEntity == null) {
        return left(const QuestionFailure.unexpected());
      }
      final options = await _database.optionDao.getOptionsForQuestion(id);
      return right(QuestionMapper.toDomain(questionEntity, options));
    } catch (e) {
      return left(const QuestionFailure.unexpected());
    }
  }

  @override
  Future<Either<QuestionFailure, Unit>> deleteQuestion(String id) async {
    try {
      //TODOswitch to transactions
      final question = await _database.questionDao.getQuestionById(id);
      if (question != null) {
        // Due to cascade delete, this will also delete related options
        await _database.questionDao.deleteQuestion(question);
      }
      return right(unit);
    } catch (e) {
      return left(const QuestionFailure.unexpected());
    }
  }
}

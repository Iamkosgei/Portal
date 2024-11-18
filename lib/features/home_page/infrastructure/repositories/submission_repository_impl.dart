import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:portal/core/database/database.dart';
import 'package:portal/core/database/mappers/submission_mapper.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/home_page/domain/entities/submission/submission.dart';
import 'package:portal/features/home_page/domain/repositories/i_submission_repository.dart';

@Injectable(as: ISubmissionRepository)
class SubmissionRepositoryImpl implements ISubmissionRepository {
  final AppDatabase _database;

  SubmissionRepositoryImpl(this._database);

  @override
  Future<Either<QuestionFailure, Unit>> createSubmission(
      Submission submission) async {
    try {
      final submissionEntity = SubmissionMapper.toEntity(submission);

      await _database.submissionDao.insertSubmission(submissionEntity);

      return right(unit);
    } catch (e) {
      return left(const QuestionFailure.unexpected());
    }
  }

  @override
  Future<Either<QuestionFailure, Unit>> deleteSubmission(String id) async {
    try {
      final submission = await _database.submissionDao.getSubmissionById(id);
      if (submission != null) {
        await _database.submissionDao.deleteSubmission(submission.id);
      }
      return right(unit);
    } catch (e) {
      return left(const QuestionFailure.unexpected());
    }
  }

  @override
  Future<Either<QuestionFailure, List<Submission>>> getAllSubmissions() async {
    try {
      final submissionEntities =
          await _database.submissionDao.getAllSubmissions();
      final submissions = await Future.wait(
        submissionEntities.map((sEntity) async {
          return SubmissionMapper.toDomain(sEntity);
        }),
      );
      return right(submissions);
    } catch (e) {
      log("Error---- $e");
      return left(const QuestionFailure.unexpected());
    }
  }

  @override
  Future<Either<QuestionFailure, Submission>> getSubmissionById(
      String id) async {
    try {
      final submissionEntity =
          await _database.submissionDao.getSubmissionById(id);
      if (submissionEntity == null) {
        return left(const QuestionFailure.unexpected());
      }
      return right(SubmissionMapper.toDomain(submissionEntity));
    } catch (e) {
      return left(const QuestionFailure.unexpected());
    }
  }
}

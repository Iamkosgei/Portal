import 'package:dartz/dartz.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/submissions/domain/entities/submission/submission.dart';

abstract class ISubmissionRepository {
  Future<Either<QuestionFailure, List<Submission>>> getAllSubmissions();
  Future<Either<QuestionFailure, Submission>> getSubmissionById(String id);
  Future<Either<QuestionFailure, Unit>> createSubmission(Submission question);
  Future<Either<QuestionFailure, Unit>> deleteSubmission(String id);
}

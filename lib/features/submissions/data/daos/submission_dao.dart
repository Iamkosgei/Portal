import 'package:floor/floor.dart';
import 'package:portal/features/submissions/data/models/submission_entity.dart';

@dao
abstract class SubmissionDao {
  @insert
  Future<void> insertSubmission(SubmissionEntity submission);

  @Query('SELECT * FROM SubmissionEntity WHERE questionId = :questionId')
  Future<List<SubmissionEntity>> getSubmissionsForQuestion(String questionId);

  @Query('SELECT * FROM SubmissionEntity')
  Future<List<SubmissionEntity>> getAllSubmissions();

  @Query('SELECT * FROM SubmissionEntity WHERE id = :id')
  Future<SubmissionEntity?> getSubmissionById(String id);

  @Query('DELETE FROM SubmissionEntity WHERE questionId = :questionId')
  Future<void> deleteSubmissionsForQuestion(String questionId);

  @Query('DELETE FROM SubmissionEntity WHERE id = :id')
  Future<void> deleteSubmission(String id);
}

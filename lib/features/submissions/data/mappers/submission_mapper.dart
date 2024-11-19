import 'package:portal/features/submissions/data/models/submission_entity.dart';
import 'package:portal/features/submissions/domain/entities/submission/submission.dart';

class SubmissionMapper {
  static Submission toDomain(SubmissionEntity entity) {
    return Submission(
      id: entity.id,
      questionId: entity.questionId,
      question: entity.question,
      submittedAnswer: entity.submittedAnswer,
      totalMarks: entity.totalMarks,
      correctAnswer: entity.correctAnswer,
    );
  }

  static SubmissionEntity toEntity(Submission domain) {
    return SubmissionEntity(
      id: domain.id,
      questionId: domain.questionId,
      question: domain.question,
      submittedAnswer: domain.submittedAnswer,
      totalMarks: domain.totalMarks,
      correctAnswer: domain.correctAnswer,
    );
  }
}

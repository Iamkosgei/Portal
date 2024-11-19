import 'package:freezed_annotation/freezed_annotation.dart';

part 'submission.freezed.dart';
part 'submission.g.dart';

@freezed
class Submission with _$Submission {
  const factory Submission({
    required String id,
    required String questionId,
    required String question,
    required String submittedAnswer,
    required int totalMarks,
    required String correctAnswer,
  }) = _Submission;

  factory Submission.fromJson(Map<String, dynamic> json) =>
      _$SubmissionFromJson(json);
}

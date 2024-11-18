import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/home_page/domain/entities/submission/submission.dart';

part 'submission_state.freezed.dart';

@freezed
class SubmissionState with _$SubmissionState {
  const factory SubmissionState.initial() = _Initial;
  const factory SubmissionState.loading() = _Loading;
  const factory SubmissionState.success(List<Submission> submissions) =
      _Success;
  const factory SubmissionState.failure(Option<QuestionFailure> failure) =
      _Failure;
  const factory SubmissionState.saved() = _Saved;
  const factory SubmissionState.deleted() = _Deleted;
}

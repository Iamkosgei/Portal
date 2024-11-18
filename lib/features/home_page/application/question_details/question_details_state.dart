import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portal/core/error/question_failure.dart';

part 'question_details_state.freezed.dart';

@freezed
class QuestionDetailsState with _$QuestionDetailsState {
  const factory QuestionDetailsState.initial() = _Initial;
  const factory QuestionDetailsState.loading() = _Loading;
  const factory QuestionDetailsState.answering() = _Answering;
  const factory QuestionDetailsState.correct() = _Correct;
  const factory QuestionDetailsState.incorrect() = _Incorrect;
  const factory QuestionDetailsState.failure(Option<QuestionFailure> failure) =
      _Failure;
}

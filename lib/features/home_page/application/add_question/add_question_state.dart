import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portal/core/error/question_failure.dart';

part 'add_question_state.freezed.dart';

@freezed
class AddQuestionState with _$AddQuestionState {
  const factory AddQuestionState.initial() = _Initial;
  const factory AddQuestionState.loading() = _Loading;
  const factory AddQuestionState.success() = _Success;
  const factory AddQuestionState.failure(Option<QuestionFailure> failure) =
      _Failure;
}

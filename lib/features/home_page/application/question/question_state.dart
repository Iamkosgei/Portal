import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/home_page/domain/entities/question/question.dart';

part 'question_state.freezed.dart';

@freezed
class QuestionState with _$QuestionState {
  const factory QuestionState.initial() = _Initial;
  const factory QuestionState.loading() = _Loading;
  const factory QuestionState.success(List<Question> questions) = _Success;
  const factory QuestionState.failure(Option<QuestionFailure> failure) =
      _Failure;
}

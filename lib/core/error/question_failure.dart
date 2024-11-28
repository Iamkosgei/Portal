import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_failure.freezed.dart';

@freezed
class QuestionFailure with _$QuestionFailure {
  const factory QuestionFailure.unexpected() = _Unexpected;
  const factory QuestionFailure.insufficientPermission() =
      _InsufficientPermission;
  const factory QuestionFailure.unableToUpdate() = _UnableToUpdate;
  const factory QuestionFailure.unableToDelete() = _UnableToDelete;
  const factory QuestionFailure.notFound() = _NotFound;
}

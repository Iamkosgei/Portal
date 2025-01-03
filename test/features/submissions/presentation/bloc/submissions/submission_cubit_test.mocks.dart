// Mocks generated by Mockito 5.4.4 from annotations
// in portal/test/features/submissions/presentation/bloc/submissions/submission_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:portal/core/error/question_failure.dart' as _i5;
import 'package:portal/features/submissions/domain/entities/submission/submission.dart'
    as _i6;
import 'package:portal/features/submissions/domain/repositories/i_submission_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ISubmissionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockISubmissionRepository extends _i1.Mock
    implements _i3.ISubmissionRepository {
  MockISubmissionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, List<_i6.Submission>>>
      getAllSubmissions() => (super.noSuchMethod(
            Invocation.method(
              #getAllSubmissions,
              [],
            ),
            returnValue: _i4.Future<
                    _i2
                    .Either<_i5.QuestionFailure, List<_i6.Submission>>>.value(
                _FakeEither_0<_i5.QuestionFailure, List<_i6.Submission>>(
              this,
              Invocation.method(
                #getAllSubmissions,
                [],
              ),
            )),
          ) as _i4
              .Future<_i2.Either<_i5.QuestionFailure, List<_i6.Submission>>>);

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, _i6.Submission>> getSubmissionById(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSubmissionById,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.QuestionFailure, _i6.Submission>>.value(
                _FakeEither_0<_i5.QuestionFailure, _i6.Submission>(
          this,
          Invocation.method(
            #getSubmissionById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.QuestionFailure, _i6.Submission>>);

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>> createSubmission(
          _i6.Submission? question) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSubmission,
          [question],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>.value(
                _FakeEither_0<_i5.QuestionFailure, _i2.Unit>(
          this,
          Invocation.method(
            #createSubmission,
            [question],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>);

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>> deleteSubmission(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteSubmission,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>.value(
                _FakeEither_0<_i5.QuestionFailure, _i2.Unit>(
          this,
          Invocation.method(
            #deleteSubmission,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>);
}

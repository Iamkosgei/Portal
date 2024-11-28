// Mocks generated by Mockito 5.4.4 from annotations
// in portal/test/features/questions/presentation/bloc/question/question_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:portal/core/error/question_failure.dart' as _i5;
import 'package:portal/features/questions/domain/entities/question/question.dart'
    as _i6;
import 'package:portal/features/questions/domain/repositories/i_question_repository.dart'
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

/// A class which mocks [IQuestionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIQuestionRepository extends _i1.Mock
    implements _i3.IQuestionRepository {
  MockIQuestionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, List<_i6.Question>>>
      getQuestions() => (super.noSuchMethod(
            Invocation.method(
              #getQuestions,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.QuestionFailure, List<_i6.Question>>>.value(
                _FakeEither_0<_i5.QuestionFailure, List<_i6.Question>>(
              this,
              Invocation.method(
                #getQuestions,
                [],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.QuestionFailure, List<_i6.Question>>>);

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, _i6.Question>> getQuestionById(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getQuestionById,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.QuestionFailure, _i6.Question>>.value(
                _FakeEither_0<_i5.QuestionFailure, _i6.Question>(
          this,
          Invocation.method(
            #getQuestionById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.QuestionFailure, _i6.Question>>);

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>> createQuestion(
          _i6.Question? question) =>
      (super.noSuchMethod(
        Invocation.method(
          #createQuestion,
          [question],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>.value(
                _FakeEither_0<_i5.QuestionFailure, _i2.Unit>(
          this,
          Invocation.method(
            #createQuestion,
            [question],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>);

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>> updateQuestion(
          _i6.Question? question) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateQuestion,
          [question],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>.value(
                _FakeEither_0<_i5.QuestionFailure, _i2.Unit>(
          this,
          Invocation.method(
            #updateQuestion,
            [question],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>);

  @override
  _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>> deleteQuestion(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteQuestion,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>.value(
                _FakeEither_0<_i5.QuestionFailure, _i2.Unit>(
          this,
          Invocation.method(
            #deleteQuestion,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.QuestionFailure, _i2.Unit>>);
}

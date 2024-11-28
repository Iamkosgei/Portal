import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:portal/features/questions/domain/repositories/i_question_repository.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_state.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/core/error/question_failure.dart';

import 'question_details_cubit_test.mocks.dart';

@GenerateMocks([IQuestionRepository])
void main() {
  late MockIQuestionRepository mockRepository;
  late AddQuestionCubit cubit;

  setUp(() {
    mockRepository = MockIQuestionRepository();
    cubit = AddQuestionCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('AddQuestionCubit', () {
    const question = Question(
      id: 'q1',
      questionText: 'What is Flutter?',
      difficulty: DifficultyLevel.easy,
      options: [],
    );

    blocTest<AddQuestionCubit, AddQuestionState>(
      'emits [loading, failure] when createQuestion fails due to unexpected error',
      build: () {
        when(mockRepository.createQuestion(question))
            .thenAnswer((_) async => const Left(QuestionFailure.unexpected()));
        return cubit;
      },
      act: (cubit) => cubit.createQuestion(question),
      expect: () => [
        const AddQuestionState.loading(),
        AddQuestionState.failure(some(const QuestionFailure.unexpected())),
      ],
      verify: (_) {
        verify(mockRepository.createQuestion(question)).called(1);
      },
    );

    blocTest<AddQuestionCubit, AddQuestionState>(
      'emits [loading, failure] when createQuestion fails due to insufficient permission',
      build: () {
        when(mockRepository.createQuestion(question)).thenAnswer(
            (_) async => const Left(QuestionFailure.insufficientPermission()));
        return cubit;
      },
      act: (cubit) => cubit.createQuestion(question),
      expect: () => [
        const AddQuestionState.loading(),
        AddQuestionState.failure(
            some(const QuestionFailure.insufficientPermission())),
      ],
      verify: (_) {
        verify(mockRepository.createQuestion(question)).called(1);
      },
    );
  });
}

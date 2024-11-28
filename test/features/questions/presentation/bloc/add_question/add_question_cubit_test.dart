import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/questions/domain/entities/option/option.dart'
    as opt;
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_state.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/domain/repositories/i_question_repository.dart';

import 'add_question_cubit_test.mocks.dart';

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
      id: '1',
      questionText: 'What is Dart?',
      difficulty: DifficultyLevel.easy,
      options: [
        opt.Option(
            id: '1',
            optionText: 'A programming language',
            questionId: '1',
            isCorrect: true),
        opt.Option(
            id: '2',
            optionText: 'A database',
            questionId: '1',
            isCorrect: false),
      ],
    );

    blocTest<AddQuestionCubit, AddQuestionState>(
      'emits [loading, success] when createQuestion succeeds',
      build: () {
        when(mockRepository.createQuestion(question))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) => cubit.createQuestion(question),
      expect: () => [
        const AddQuestionState.loading(),
        const AddQuestionState.success(),
      ],
      verify: (_) {
        verify(mockRepository.createQuestion(question)).called(1);
      },
    );

    blocTest<AddQuestionCubit, AddQuestionState>(
      'emits [loading, failure] when createQuestion fails',
      build: () {
        when(mockRepository.createQuestion(question))
            .thenAnswer((_) async => const Left(QuestionFailure.notFound()));
        return cubit;
      },
      act: (cubit) => cubit.createQuestion(question),
      expect: () => [
        const AddQuestionState.loading(),
        AddQuestionState.failure(some(const QuestionFailure.notFound())),
      ],
      verify: (_) {
        verify(mockRepository.createQuestion(question)).called(1);
      },
    );

    blocTest<AddQuestionCubit, AddQuestionState>(
      'emits [loading, success] when updateQuestion succeeds',
      build: () {
        when(mockRepository.updateQuestion(question))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) => cubit.updateQuestion(question),
      expect: () => [
        const AddQuestionState.loading(),
        const AddQuestionState.success(),
      ],
      verify: (_) {
        verify(mockRepository.updateQuestion(question)).called(1);
      },
    );

    blocTest<AddQuestionCubit, AddQuestionState>(
      'emits [loading, failure] when updateQuestion fails',
      build: () {
        when(mockRepository.updateQuestion(question))
            .thenAnswer((_) async => const Left(QuestionFailure.notFound()));
        return cubit;
      },
      act: (cubit) => cubit.updateQuestion(question),
      expect: () => [
        const AddQuestionState.loading(),
        AddQuestionState.failure(some(const QuestionFailure.notFound())),
      ],
      verify: (_) {
        verify(mockRepository.updateQuestion(question)).called(1);
      },
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/questions/presentation/bloc/question/question_cubit.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/domain/repositories/i_question_repository.dart';
import 'package:portal/features/questions/presentation/bloc/question/question_state.dart';

import 'question_cubit_test.mocks.dart';

@GenerateMocks([IQuestionRepository])
void main() {
  late MockIQuestionRepository mockRepository;
  late QuestionCubit cubit;

  setUp(() {
    mockRepository = MockIQuestionRepository();
    cubit = QuestionCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('QuestionCubit', () {
    const question1 = Question(
      id: '1',
      questionText: 'What is Flutter?',
      difficulty: DifficultyLevel.medium,
      options: [],
    );
    const question2 = Question(
      id: '2',
      questionText: 'What is Dart?',
      difficulty: DifficultyLevel.easy,
      options: [],
    );
    const question3 = Question(
      id: '3',
      questionText: 'What is Bloc?',
      difficulty: DifficultyLevel.hard,
      options: [],
    );

    blocTest<QuestionCubit, QuestionState>(
      'emits [loading, success] when loadQuestions succeeds',
      build: () {
        when(mockRepository.getQuestions()).thenAnswer(
            (_) async => const Right([question1, question2, question3]));
        return cubit;
      },
      act: (cubit) => cubit.loadQuestions(),
      expect: () => [
        const QuestionState.loading(),
        const QuestionState.success([question3, question2, question1]),
      ],
      verify: (_) {
        verify(mockRepository.getQuestions()).called(1);
      },
    );

    blocTest<QuestionCubit, QuestionState>(
      'emits [loading, failure] when loadQuestions fails',
      build: () {
        when(mockRepository.getQuestions())
            .thenAnswer((_) async => const Left(QuestionFailure.unexpected()));
        return cubit;
      },
      act: (cubit) => cubit.loadQuestions(),
      expect: () => [
        const QuestionState.loading(),
        QuestionState.failure(some(const QuestionFailure.unexpected())),
      ],
      verify: (_) {
        verify(mockRepository.getQuestions()).called(1);
      },
    );

    blocTest<QuestionCubit, QuestionState>(
      'emits [success] with filtered questions when filterQuestions is called with difficulty',
      build: () {
        when(mockRepository.getQuestions()).thenAnswer(
            (_) async => const Right([question1, question2, question3]));
        return cubit;
      },
      act: (cubit) => cubit.loadQuestions(),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        const QuestionState.loading(),
        const QuestionState.success([question3, question2, question1]),
      ],
    );

    blocTest<QuestionCubit, QuestionState>(
      'emits [success] with filtered questions when filterQuestions is called with difficulty medium',
      build: () {
        when(mockRepository.getQuestions()).thenAnswer(
          (_) async => const Right([question1, question2, question3]),
        );
        return cubit;
      },
      act: (cubit) async {
        await cubit.loadQuestions();
        cubit.filterQuestions(DifficultyLevel.medium);
      },
      expect: () => [
        const QuestionState.loading(),
        const QuestionState.success([question3, question2, question1]),
        const QuestionState.success([question1]),
      ],
      verify: (_) {
        verify(mockRepository.getQuestions()).called(1);
      },
    );

    blocTest<QuestionCubit, QuestionState>(
      'emits [success] with all questions when filterQuestions is called with null difficulty',
      build: () {
        when(mockRepository.getQuestions()).thenAnswer(
            (_) async => const Right([question1, question2, question3]));
        return cubit;
      },
      act: (cubit) => cubit.loadQuestions(),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        const QuestionState.loading(),
        const QuestionState.success([question3, question2, question1]),
      ],
      verify: (_) {
        verify(mockRepository.getQuestions()).called(1);
      },
    );
  });
}

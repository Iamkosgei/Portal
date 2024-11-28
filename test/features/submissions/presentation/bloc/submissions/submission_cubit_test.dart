import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/submissions/domain/entities/submission/submission.dart';
import 'package:portal/features/submissions/domain/repositories/i_submission_repository.dart';
import 'package:portal/features/submissions/presentation/bloc/submissions/submission_cubit.dart';
import 'package:portal/features/submissions/presentation/bloc/submissions/submission_state.dart';

import 'submission_cubit_test.mocks.dart';

@GenerateMocks([ISubmissionRepository])
void main() {
  late MockISubmissionRepository mockRepository;
  late SubmissionCubit cubit;

  setUp(() {
    mockRepository = MockISubmissionRepository();
    cubit = SubmissionCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('SubmissionCubit', () {
    const submission = Submission(
      id: '1',
      questionId: 'q1',
      question: 'What is Flutter?',
      submittedAnswer:
          'A UI toolkit for building natively compiled applications.',
      totalMarks: 10,
      correctAnswer:
          'A UI toolkit for building natively compiled applications.',
    );

    blocTest<SubmissionCubit, SubmissionState>(
      'emits [loading, success] when loadAllSubmissions succeeds',
      build: () {
        when(mockRepository.getAllSubmissions()).thenAnswer(
            (_) async => const Right([submission])); // Correct 'when'
        return SubmissionCubit(mockRepository); // Ensure valid return
      },
      act: (cubit) => cubit.loadAllSubmissions(),
      expect: () => [
        const SubmissionState.loading(),
        const SubmissionState.success([submission]),
      ],
      verify: (_) {
        verify(mockRepository.getAllSubmissions()).called(1);
      },
    );

    blocTest<SubmissionCubit, SubmissionState>(
      'emits [loading, saved, success] when saveSubmission succeeds',
      build: () {
        when(mockRepository.createSubmission(submission))
            .thenAnswer((_) async => const Right(unit));
        when(mockRepository.getAllSubmissions())
            .thenAnswer((_) async => const Right([submission]));
        return cubit;
      },
      act: (cubit) => cubit.saveSubmission(submission),
      expect: () => [
        const SubmissionState.loading(),
        const SubmissionState.saved(),
        const SubmissionState.loading(),
        const SubmissionState.success([submission]),
      ],
    );

    blocTest<SubmissionCubit, SubmissionState>(
      'emits [loading, failure] when saveSubmission fails',
      build: () {
        when(mockRepository.createSubmission(submission))
            .thenAnswer((_) async => const Left(QuestionFailure.notFound()));
        when(mockRepository.getAllSubmissions())
            .thenAnswer((_) async => const Right([submission]));
        return cubit;
      },
      act: (cubit) => cubit.saveSubmission(submission),
      expect: () => [
        const SubmissionState.loading(),
        SubmissionState.failure(some(const QuestionFailure.notFound())),
        const SubmissionState.loading(),
        const SubmissionState.success([submission]),
      ],
    );

    blocTest<SubmissionCubit, SubmissionState>(
      'emits [loading, deleted, success] when deleteSubmissionsForQuestion succeeds',
      build: () {
        when(mockRepository.deleteSubmission('q1'))
            .thenAnswer((_) async => const Right(unit));
        when(mockRepository.getAllSubmissions())
            .thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.deleteSubmissionsForQuestion('q1'),
      expect: () => [
        const SubmissionState.loading(),
        const SubmissionState.deleted(),
        const SubmissionState.loading(),
        const SubmissionState.success([]),
      ],
    );

    blocTest<SubmissionCubit, SubmissionState>(
      'emits [loading, failure] when deleteSubmissionsForQuestion fails',
      build: () {
        when(mockRepository.deleteSubmission('q1'))
            .thenAnswer((_) async => const Left(QuestionFailure.unexpected()));
        when(mockRepository.getAllSubmissions())
            .thenAnswer((_) async => const Right([submission]));
        return cubit;
      },
      act: (cubit) => cubit.deleteSubmissionsForQuestion('q1'),
      expect: () => [
        const SubmissionState.loading(),
        SubmissionState.failure(some(const QuestionFailure.unexpected())),
        const SubmissionState.loading(),
        const SubmissionState.success([submission]),
      ],
    );
  });
}

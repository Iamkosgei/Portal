import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/questions/presentation/bloc/delete_question/delete_question_cubit.dart';
import 'package:portal/features/questions/domain/repositories/i_question_repository.dart';

import 'delete_question_cubit_test.mocks.dart';

@GenerateMocks([IQuestionRepository])
void main() {
  late MockIQuestionRepository mockRepository;
  late DeleteQuestionCubit cubit;

  setUp(() {
    mockRepository = MockIQuestionRepository();
    cubit = DeleteQuestionCubit(mockRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('DeleteQuestionCubit', () {
    const questionId = '1';

    blocTest<DeleteQuestionCubit, bool>(
      'emits [false, true] when deleteQuestion succeeds',
      build: () {
        when(mockRepository.deleteQuestion(questionId))
            .thenAnswer((_) async => const Right(unit));
        return cubit;
      },
      act: (cubit) => cubit.deleteQuestion(questionId),
      expect: () => [
        false,
        true,
      ],
      verify: (_) {
        verify(mockRepository.deleteQuestion(questionId)).called(1);
      },
    );

    blocTest<DeleteQuestionCubit, bool>(
      'emits [false, false] when deleteQuestion fails',
      build: () {
        when(mockRepository.deleteQuestion(questionId))
            .thenAnswer((_) async => const Left(QuestionFailure.notFound()));
        return cubit;
      },
      act: (cubit) => cubit.deleteQuestion(questionId),
      expect: () => [
        false,
      ],
      verify: (_) {
        verify(mockRepository.deleteQuestion(questionId)).called(1);
      },
    );
  });
}

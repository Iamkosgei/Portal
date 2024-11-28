import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:portal/core/database/database.dart';

import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/submissions/data/daos/submission_dao.dart';
import 'package:portal/features/submissions/domain/entities/submission/submission.dart';
import 'package:portal/features/submissions/data/repositories/submission_repository_impl.dart';
import 'package:portal/features/submissions/data/models/submission_entity.dart';

import 'submission_repository_impl_test.mocks.dart';

@GenerateMocks([AppDatabase, SubmissionDao])
void main() {
  late MockAppDatabase mockDatabase;
  late MockSubmissionDao mockSubmissionDao;
  late SubmissionRepositoryImpl repository;

  setUp(() {
    mockDatabase = MockAppDatabase();
    mockSubmissionDao = MockSubmissionDao();

    when(mockDatabase.submissionDao).thenReturn(mockSubmissionDao);

    repository = SubmissionRepositoryImpl(mockDatabase);
  });

  group('SubmissionRepositoryImpl', () {
    final testSubmissionEntity = SubmissionEntity(
        id: '1',
        questionId: 'question1',
        question: 'Test Question',
        submittedAnswer: 'Option A',
        totalMarks: 10,
        correctAnswer: 'Option B');

    const testSubmission = Submission(
        id: '1',
        questionId: 'question1',
        question: 'Test Question',
        submittedAnswer: 'Option A',
        totalMarks: 10,
        correctAnswer: 'Option B');

    test('createSubmission - success', () async {
      // Act
      final result = await repository.createSubmission(testSubmission);

      // Assert
      expect(result.isRight(), true);
      verify(mockSubmissionDao.insertSubmission(any)).called(1);
    });

    test('createSubmission - failure', () async {
      // Arrange
      when(mockSubmissionDao.insertSubmission(any))
          .thenThrow(Exception('Database error'));

      // Act
      final result = await repository.createSubmission(testSubmission);

      // Assert
      expect(result.isLeft(), true);
      expect(
          result.fold((l) => l, (r) => r), const QuestionFailure.unexpected());
    });

    test('deleteSubmission - success', () async {
      // Arrange
      when(mockSubmissionDao.getSubmissionById('1'))
          .thenAnswer((_) async => testSubmissionEntity);

      // Act
      final result = await repository.deleteSubmission('1');

      // Assert
      expect(result.isRight(), true);
      verify(mockSubmissionDao.deleteSubmission(testSubmissionEntity.id))
          .called(1);
    });

    test('getAllSubmissions - success', () async {
      // Arrange
      when(mockSubmissionDao.getAllSubmissions())
          .thenAnswer((_) async => [testSubmissionEntity]);

      // Act
      final result = await repository.getAllSubmissions();

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should be right'), (submissions) {
        expect(submissions.length, 1);
        expect(submissions[0].id, testSubmissionEntity.id);
      });
    });

    test('getSubmissionById - success', () async {
      // Arrange
      when(mockSubmissionDao.getSubmissionById('1'))
          .thenAnswer((_) async => testSubmissionEntity);

      // Act
      final result = await repository.getSubmissionById('1');

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should be right'), (submission) {
        expect(submission.id, testSubmissionEntity.id);
      });
    });
  });
}

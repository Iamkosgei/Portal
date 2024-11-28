import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:portal/core/database/database.dart';
import 'package:portal/core/error/question_failure.dart';
import 'package:portal/features/questions/data/daos/option_dao.dart';
import 'package:portal/features/questions/data/daos/question_dao.dart';
import 'package:portal/features/questions/data/models/option_entity.dart';
import 'package:portal/features/questions/data/models/question_entity.dart';
import 'package:portal/features/questions/data/repositories/question_repository_impl.dart';
import 'package:portal/features/questions/domain/entities/option/option.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';

import 'question_repository_impl_test.mocks.dart';

@GenerateMocks([AppDatabase, QuestionDao, OptionDao])
void main() {
  late MockAppDatabase mockDatabase;
  late MockQuestionDao mockQuestionDao;
  late MockOptionDao mockOptionDao;
  late QuestionRepositoryImpl repository;

  setUp(() {
    mockDatabase = MockAppDatabase();
    mockQuestionDao = MockQuestionDao();
    mockOptionDao = MockOptionDao();

    when(mockDatabase.questionDao).thenReturn(mockQuestionDao);
    when(mockDatabase.optionDao).thenReturn(mockOptionDao);

    repository = QuestionRepositoryImpl(mockDatabase);
  });

  group('QuestionRepositoryImpl', () {
    final testQuestionEntity = QuestionEntity(
        id: '1',
        questionText: 'Test Question',
        difficulty: DifficultyLevel.easy.toString());

    final testOptionEntities = [
      OptionEntity(
          id: '1', questionId: '1', optionText: 'Option 1', isCorrect: true),
      OptionEntity(
          id: '2', questionId: '1', optionText: 'Option 2', isCorrect: false)
    ];

    test('getQuestions - success', () async {
      // Arrange
      when(mockQuestionDao.getAllQuestions())
          .thenAnswer((_) async => [testQuestionEntity]);

      when(mockOptionDao.getOptionsForQuestion(testQuestionEntity.id))
          .thenAnswer((_) async => testOptionEntities);

      // Act
      final result = await repository.getQuestions();

      // Assert
      expect(result.isRight(), true, reason: 'Result should be Right');
      result.fold((failure) => print('Unexpected Left: $failure'), (questions) {
        expect(questions.length, 1);
        expect(questions[0].id, testQuestionEntity.id);
        expect(questions[0].options.length, 2);
      });
    });

    test('getQuestions - failure', () async {
      // Arrange
      when(mockQuestionDao.getAllQuestions())
          .thenThrow(Exception('Database error'));

      // Act
      final result = await repository.getQuestions();

      // Assert
      expect(result.isLeft(), true);
      result.fold(
          (failure) => expect(failure, const QuestionFailure.unexpected()),
          (_) => fail('Should be left'));
    });

    test('createQuestion - success', () async {
      // Arrange
      const testQuestion = Question(
          id: '1',
          questionText: 'Test Question',
          difficulty: DifficultyLevel.easy,
          options: [
            Option(
                id: '1',
                questionId: '1',
                optionText: 'Option 1',
                isCorrect: true),
            Option(
                id: '2',
                questionId: '1',
                optionText: 'Option 2',
                isCorrect: false)
          ]);

      // Act
      final result = await repository.createQuestion(testQuestion);

      // Assert
      expect(result.isRight(), true);
      verify(mockQuestionDao.insertQuestion(any)).called(1);
      verify(mockOptionDao.insertOption(any)).called(2);
    });

    test('updateQuestion - success', () async {
      // Arrange
      const testQuestion = Question(
          id: '1',
          questionText: 'Updated Question',
          difficulty: DifficultyLevel.easy,
          options: [
            Option(
                id: '1',
                questionId: '1',
                optionText: 'New Option 1',
                isCorrect: true)
          ]);

      when(mockOptionDao.getOptionsForQuestion(testQuestion.id))
          .thenAnswer((_) async => testOptionEntities);

      // Act
      final result = await repository.updateQuestion(testQuestion);

      // Assert
      expect(result.isRight(), true);
      verify(mockQuestionDao.updateQuestion(any)).called(1);
      verify(mockOptionDao.deleteOption(any)).called(2);
      verify(mockOptionDao.insertOption(any)).called(1);
    });

    test('getQuestionById - success', () async {
      // Arrange
      when(mockQuestionDao.getQuestionById('1'))
          .thenAnswer((_) async => testQuestionEntity);

      when(mockOptionDao.getOptionsForQuestion('1'))
          .thenAnswer((_) async => testOptionEntities);

      final expectedDifficulty = DifficultyLevel.values.firstWhere((e) =>
          e.toString().split('.').last ==
          testQuestionEntity.difficulty.split('.').last);

      // Act
      final result = await repository.getQuestionById('1');

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should be right'), (question) {
        expect(question.id, '1');
        expect(question.difficulty, expectedDifficulty);
        expect(question.options.length, 2);
      });
    });

    test('deleteQuestion - success', () async {
      // Arrange
      when(mockQuestionDao.getQuestionById('1'))
          .thenAnswer((_) async => testQuestionEntity);

      // Act
      final result = await repository.deleteQuestion('1');

      // Assert
      expect(result.isRight(), true);
      verify(mockQuestionDao.deleteQuestion(testQuestionEntity)).called(1);
    });
  });
}

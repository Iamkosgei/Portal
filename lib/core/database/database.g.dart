// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  QuestionDao? _questionDaoInstance;

  OptionDao? _optionDaoInstance;

  SubmissionDao? _submissionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `QuestionEntity` (`id` TEXT NOT NULL, `questionText` TEXT NOT NULL, `difficulty` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OptionEntity` (`id` TEXT NOT NULL, `questionId` TEXT NOT NULL, `optionText` TEXT NOT NULL, `isCorrect` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SubmissionEntity` (`id` TEXT NOT NULL, `questionId` TEXT NOT NULL, `question` TEXT NOT NULL, `submittedAnswer` TEXT NOT NULL, `totalMarks` INTEGER NOT NULL, `correctAnswer` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  QuestionDao get questionDao {
    return _questionDaoInstance ??= _$QuestionDao(database, changeListener);
  }

  @override
  OptionDao get optionDao {
    return _optionDaoInstance ??= _$OptionDao(database, changeListener);
  }

  @override
  SubmissionDao get submissionDao {
    return _submissionDaoInstance ??= _$SubmissionDao(database, changeListener);
  }
}

class _$QuestionDao extends QuestionDao {
  _$QuestionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _questionEntityInsertionAdapter = InsertionAdapter(
            database,
            'QuestionEntity',
            (QuestionEntity item) => <String, Object?>{
                  'id': item.id,
                  'questionText': item.questionText,
                  'difficulty': item.difficulty
                }),
        _questionEntityUpdateAdapter = UpdateAdapter(
            database,
            'QuestionEntity',
            ['id'],
            (QuestionEntity item) => <String, Object?>{
                  'id': item.id,
                  'questionText': item.questionText,
                  'difficulty': item.difficulty
                }),
        _questionEntityDeletionAdapter = DeletionAdapter(
            database,
            'QuestionEntity',
            ['id'],
            (QuestionEntity item) => <String, Object?>{
                  'id': item.id,
                  'questionText': item.questionText,
                  'difficulty': item.difficulty
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<QuestionEntity> _questionEntityInsertionAdapter;

  final UpdateAdapter<QuestionEntity> _questionEntityUpdateAdapter;

  final DeletionAdapter<QuestionEntity> _questionEntityDeletionAdapter;

  @override
  Future<List<QuestionEntity>> getAllQuestions() async {
    return _queryAdapter.queryList('SELECT * FROM QuestionEntity',
        mapper: (Map<String, Object?> row) => QuestionEntity(
            id: row['id'] as String,
            questionText: row['questionText'] as String,
            difficulty: row['difficulty'] as String));
  }

  @override
  Future<QuestionEntity?> getQuestionById(String id) async {
    return _queryAdapter.query('SELECT * FROM QuestionEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => QuestionEntity(
            id: row['id'] as String,
            questionText: row['questionText'] as String,
            difficulty: row['difficulty'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertQuestion(QuestionEntity question) async {
    await _questionEntityInsertionAdapter.insert(
        question, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateQuestion(QuestionEntity question) async {
    await _questionEntityUpdateAdapter.update(
        question, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteQuestion(QuestionEntity question) async {
    await _questionEntityDeletionAdapter.delete(question);
  }
}

class _$OptionDao extends OptionDao {
  _$OptionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _optionEntityInsertionAdapter = InsertionAdapter(
            database,
            'OptionEntity',
            (OptionEntity item) => <String, Object?>{
                  'id': item.id,
                  'questionId': item.questionId,
                  'optionText': item.optionText,
                  'isCorrect': item.isCorrect ? 1 : 0
                }),
        _optionEntityUpdateAdapter = UpdateAdapter(
            database,
            'OptionEntity',
            ['id'],
            (OptionEntity item) => <String, Object?>{
                  'id': item.id,
                  'questionId': item.questionId,
                  'optionText': item.optionText,
                  'isCorrect': item.isCorrect ? 1 : 0
                }),
        _optionEntityDeletionAdapter = DeletionAdapter(
            database,
            'OptionEntity',
            ['id'],
            (OptionEntity item) => <String, Object?>{
                  'id': item.id,
                  'questionId': item.questionId,
                  'optionText': item.optionText,
                  'isCorrect': item.isCorrect ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OptionEntity> _optionEntityInsertionAdapter;

  final UpdateAdapter<OptionEntity> _optionEntityUpdateAdapter;

  final DeletionAdapter<OptionEntity> _optionEntityDeletionAdapter;

  @override
  Future<List<OptionEntity>> getOptionsForQuestion(String questionId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM OptionEntity WHERE questionId = ?1',
        mapper: (Map<String, Object?> row) => OptionEntity(
            id: row['id'] as String,
            questionId: row['questionId'] as String,
            optionText: row['optionText'] as String,
            isCorrect: (row['isCorrect'] as int) != 0),
        arguments: [questionId]);
  }

  @override
  Future<void> insertOption(OptionEntity option) async {
    await _optionEntityInsertionAdapter.insert(
        option, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOption(OptionEntity option) async {
    await _optionEntityUpdateAdapter.update(option, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOption(OptionEntity option) async {
    await _optionEntityDeletionAdapter.delete(option);
  }
}

class _$SubmissionDao extends SubmissionDao {
  _$SubmissionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _submissionEntityInsertionAdapter = InsertionAdapter(
            database,
            'SubmissionEntity',
            (SubmissionEntity item) => <String, Object?>{
                  'id': item.id,
                  'questionId': item.questionId,
                  'question': item.question,
                  'submittedAnswer': item.submittedAnswer,
                  'totalMarks': item.totalMarks,
                  'correctAnswer': item.correctAnswer
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SubmissionEntity> _submissionEntityInsertionAdapter;

  @override
  Future<List<SubmissionEntity>> getSubmissionsForQuestion(
      String questionId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM SubmissionEntity WHERE questionId = ?1',
        mapper: (Map<String, Object?> row) => SubmissionEntity(
            id: row['id'] as String,
            questionId: row['questionId'] as String,
            question: row['question'] as String,
            submittedAnswer: row['submittedAnswer'] as String,
            totalMarks: row['totalMarks'] as int,
            correctAnswer: row['correctAnswer'] as String),
        arguments: [questionId]);
  }

  @override
  Future<List<SubmissionEntity>> getAllSubmissions() async {
    return _queryAdapter.queryList('SELECT * FROM SubmissionEntity',
        mapper: (Map<String, Object?> row) => SubmissionEntity(
            id: row['id'] as String,
            questionId: row['questionId'] as String,
            question: row['question'] as String,
            submittedAnswer: row['submittedAnswer'] as String,
            totalMarks: row['totalMarks'] as int,
            correctAnswer: row['correctAnswer'] as String));
  }

  @override
  Future<SubmissionEntity?> getSubmissionById(String id) async {
    return _queryAdapter.query('SELECT * FROM SubmissionEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SubmissionEntity(
            id: row['id'] as String,
            questionId: row['questionId'] as String,
            question: row['question'] as String,
            submittedAnswer: row['submittedAnswer'] as String,
            totalMarks: row['totalMarks'] as int,
            correctAnswer: row['correctAnswer'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteSubmissionsForQuestion(String questionId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM SubmissionEntity WHERE questionId = ?1',
        arguments: [questionId]);
  }

  @override
  Future<void> deleteSubmission(String id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM SubmissionEntity WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertSubmission(SubmissionEntity submission) async {
    await _submissionEntityInsertionAdapter.insert(
        submission, OnConflictStrategy.abort);
  }
}

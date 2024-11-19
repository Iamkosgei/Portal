import 'dart:async';
import 'package:floor/floor.dart';
import 'package:portal/features/questions/data/daos/option_dao.dart';
import 'package:portal/features/questions/data/daos/question_dao.dart';
import 'package:portal/features/submissions/data/daos/submission_dao.dart';
import 'package:portal/features/questions/data/models/option_entity.dart';
import 'package:portal/features/questions/data/models/question_entity.dart';
import 'package:portal/features/submissions/data/models/submission_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(
    version: 1, entities: [QuestionEntity, OptionEntity, SubmissionEntity])
abstract class AppDatabase extends FloorDatabase {
  QuestionDao get questionDao;
  OptionDao get optionDao;
  SubmissionDao get submissionDao;
}

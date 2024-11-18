import 'dart:async';
import 'package:floor/floor.dart';
import 'package:portal/core/database/daos/option_dao.dart';
import 'package:portal/core/database/daos/question_dao.dart';
import 'package:portal/core/database/daos/submission_dao.dart';
import 'package:portal/core/database/entities/option_entity.dart';
import 'package:portal/core/database/entities/question_entity.dart';
import 'package:portal/core/database/entities/submission_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(
    version: 1, entities: [QuestionEntity, OptionEntity, SubmissionEntity])
abstract class AppDatabase extends FloorDatabase {
  QuestionDao get questionDao;
  OptionDao get optionDao;
  SubmissionDao get submissionDao;
}

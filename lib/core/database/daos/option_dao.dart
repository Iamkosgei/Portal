import 'package:floor/floor.dart';
import 'package:portal/core/database/entities/option_entity.dart';

@dao
abstract class OptionDao {
  @Query('SELECT * FROM OptionEntity WHERE questionId = :questionId')
  Future<List<OptionEntity>> getOptionsForQuestion(String questionId);

  @insert
  Future<void> insertOption(OptionEntity option);

  @update
  Future<void> updateOption(OptionEntity option);

  @delete
  Future<void> deleteOption(OptionEntity option);
}

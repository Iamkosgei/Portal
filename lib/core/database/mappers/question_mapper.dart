import 'package:portal/core/database/entities/option_entity.dart';
import 'package:portal/core/database/entities/question_entity.dart';
import 'package:portal/features/home_page/domain/entities/option/option.dart';
import 'package:portal/features/home_page/domain/entities/question/question.dart';

class QuestionMapper {
  static Question toDomain(QuestionEntity entity, List<OptionEntity> options) {
    return Question(
      id: entity.id,
      questionText: entity.questionText,
      difficulty: DifficultyLevel.values.firstWhere(
        (e) => e.toString().split('.').last == entity.difficulty,
      ),
      options: options
          .map((opt) => Option(
                id: opt.id,
                questionId: opt.questionId,
                optionText: opt.optionText,
                isCorrect: opt.isCorrect,
              ))
          .toList(),
    );
  }

  static QuestionEntity toEntity(Question domain) {
    return QuestionEntity(
      id: domain.id,
      questionText: domain.questionText,
      difficulty: domain.difficulty.toString().split('.').last,
    );
  }

  static List<OptionEntity> optionsToEntities(Question domain) {
    return domain.options
        .map((opt) => OptionEntity(
              id: opt.id,
              questionId: domain.id,
              optionText: opt.optionText,
              isCorrect: opt.isCorrect,
            ))
        .toList();
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portal/features/home_page/application/question/question_state.dart';
import 'package:portal/features/home_page/domain/entities/question/question.dart';
import 'package:portal/features/home_page/domain/repositories/i_question_repository.dart';

@injectable
class QuestionCubit extends Cubit<QuestionState> {
  final IQuestionRepository _repository;
  List<Question> _allQuestions = [];

  QuestionCubit(this._repository) : super(const QuestionState.initial());

  Future<void> loadQuestions() async {
    emit(const QuestionState.loading());
    final failureOrQuestions = await _repository.getQuestions();
    failureOrQuestions.fold(
      (failure) => emit(QuestionState.failure(some(failure))),
      (questions) {
        _allQuestions = questions.reversed.toList();
        emit(QuestionState.success(_allQuestions));
      },
    );
  }

  void filterQuestions(DifficultyLevel? difficulty) {
    if (difficulty == null) {
      emit(QuestionState.success(_allQuestions));
    } else {
      final filteredQuestions =
          _allQuestions.where((q) => q.difficulty == difficulty).toList();
      emit(QuestionState.success(filteredQuestions));
    }
  }
}

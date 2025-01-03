import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_state.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/domain/repositories/i_question_repository.dart';

@injectable
class AddQuestionCubit extends Cubit<AddQuestionState> {
  final IQuestionRepository _repository;

  AddQuestionCubit(this._repository) : super(const AddQuestionState.initial());

  Future<void> createQuestion(Question question) async {
    emit(const AddQuestionState.loading());
    final failureOrSuccess = await _repository.createQuestion(question);
    emit(
      failureOrSuccess.fold(
        (failure) => AddQuestionState.failure(some(failure)),
        (_) => const AddQuestionState.success(),
      ),
    );
  }

  Future<void> updateQuestion(Question question) async {
    emit(const AddQuestionState.loading());
    final failureOrSuccess = await _repository.updateQuestion(question);
    emit(
      failureOrSuccess.fold(
        (failure) => AddQuestionState.failure(some(failure)),
        (_) => const AddQuestionState.success(),
      ),
    );
  }
}

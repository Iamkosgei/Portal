import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portal/features/questions/domain/repositories/i_question_repository.dart';

@injectable
class DeleteQuestionCubit extends Cubit<bool> {
  final IQuestionRepository _repository;

  DeleteQuestionCubit(this._repository) : super(false);

  Future<void> deleteQuestion(String questionId) async {
    emit(false);
    final result = await _repository.deleteQuestion(questionId);
    result.fold(
      (failure) {
        emit(false);
      },
      (_) {
        emit(true);
      },
    );
  }
}

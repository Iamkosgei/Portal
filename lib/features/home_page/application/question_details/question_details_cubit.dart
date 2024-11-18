import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portal/features/home_page/application/question_details/question_details_state.dart';
import 'package:portal/features/home_page/domain/entities/question/question.dart';
import 'package:portal/features/home_page/domain/entities/submission/submission.dart';
import 'package:portal/features/home_page/domain/repositories/i_submission_repository.dart';
import 'package:uuid/uuid.dart';

@injectable
class QuestionDetailsCubit extends Cubit<QuestionDetailsState> {
  final ISubmissionRepository _iSubmissionRepository;
  QuestionDetailsCubit(this._iSubmissionRepository)
      : super(const QuestionDetailsState.initial());

  Future<void> validateAnswer(
      Question question, String selectedOptionId) async {
    emit(const QuestionDetailsState.loading());

    final correctOption = question.options.firstWhereOrNull(
      (e) => e.isCorrect,
    );

    final isCorrect = correctOption?.id == selectedOptionId;

    final optionText = question.options.firstWhereOrNull(
      (e) => e.id == selectedOptionId,
    );

    final submission = Submission(
        id: const Uuid().v4(),
        questionId: question.id,
        question: question.questionText,
        submittedAnswer: optionText?.optionText ?? "N/A",
        totalMarks: isCorrect ? 1 : 0,
        correctAnswer: correctOption?.optionText ?? "");

    _iSubmissionRepository.createSubmission(submission);

    emit(
      isCorrect
          ? const QuestionDetailsState.correct()
          : const QuestionDetailsState.incorrect(),
    );
  }
}

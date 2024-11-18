import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:portal/features/home_page/application/submissions/submission_state.dart';
import 'package:portal/features/home_page/domain/entities/submission/submission.dart';
import 'package:portal/features/home_page/domain/repositories/i_submission_repository.dart';

@injectable
class SubmissionCubit extends Cubit<SubmissionState> {
  final ISubmissionRepository _repository;

  SubmissionCubit(this._repository) : super(const SubmissionState.initial());

  Future<void> loadAllSubmissions() async {
    emit(const SubmissionState.loading());
    final failureOrSubmissions = await _repository.getAllSubmissions();
    emit(
      failureOrSubmissions.fold(
        (failure) => SubmissionState.failure(some(failure)),
        (submissions) => SubmissionState.success(submissions),
      ),
    );
  }

  Future<void> saveSubmission(Submission submission) async {
    emit(const SubmissionState.loading());
    final failureOrSuccess = await _repository.createSubmission(submission);
    emit(
      failureOrSuccess.fold(
        (failure) => SubmissionState.failure(some(failure)),
        (_) => const SubmissionState.saved(),
      ),
    );
    await loadAllSubmissions();
  }

  Future<void> deleteSubmissionsForQuestion(String questionId) async {
    emit(const SubmissionState.loading());
    final failureOrSuccess = await _repository.deleteSubmission(questionId);
    emit(
      failureOrSuccess.fold(
        (failure) => SubmissionState.failure(some(failure)),
        (_) => const SubmissionState.deleted(),
      ),
    );
    await loadAllSubmissions();
  }
}

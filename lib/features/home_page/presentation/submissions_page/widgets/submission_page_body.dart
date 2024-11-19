import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/features/home_page/application/submissions/submission_cubit.dart';
import 'package:portal/features/home_page/application/submissions/submission_state.dart';
import 'package:portal/features/home_page/presentation/submissions_page/widgets/submission_card.dart';

class SubmissionPageBody extends StatelessWidget {
  const SubmissionPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: RefreshIndicator(
        onRefresh: () {
          context.read<SubmissionCubit>().loadAllSubmissions();
          return Future.value();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Submissions',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: BlocBuilder<SubmissionCubit, SubmissionState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (submissions) => submissions.isEmpty
                    ? Center(
                        child: Text(
                          "No submittions yet",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: submissions.length,
                        itemBuilder: (context, index) {
                          final submission = submissions[index];
                          return SubmissionCard(submission: submission);
                        },
                      ),
                failure: (message) => Center(
                  child: Text('Error: $message'),
                ),
                saved: () => const SizedBox(),
                deleted: () => const SizedBox(),
              );
            },
          ),
        ),
      ),
    );
  }
}

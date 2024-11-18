import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal/core/common/ui_utils.dart';
import 'package:portal/core/service_locator/get_it.dart';
import 'package:portal/features/home_page/application/submissions/submission_cubit.dart';
import 'package:portal/features/home_page/application/submissions/submission_state.dart';
import 'package:portal/features/home_page/domain/entities/submission/submission.dart';

class SubmissionsPage extends StatelessWidget {
  const SubmissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubmissionCubit>()..loadAllSubmissions(),
      child: const SubmissionPageBody(),
    );
  }
}

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

class SubmissionCard extends StatelessWidget {
  final Submission submission;

  const SubmissionCard({
    super.key,
    required this.submission,
  });

  @override
  Widget build(BuildContext context) {
    final isCorrect = submission.correctAnswer == submission.submittedAnswer;
    return Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/submission_bg.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ListTile(
          isThreeLine: true,
          title: Text(
            submission.question,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                'Your Answer: ${submission.submittedAnswer}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              if (!isCorrect)
                const SizedBox(
                  height: 8,
                ),
              if (!isCorrect)
                Text(
                  'Correct Answer: ${submission.correctAnswer}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Marks: ${submission.totalMarks}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
            ),
            child: Text(
              isCorrect ? "Correct" : "Wrong",
              style: TextStyle(
                color: (isCorrect ? Colors.green : Colors.red),
              ),
            ),
          ),
        ));
  }
}

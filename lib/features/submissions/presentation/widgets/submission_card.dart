import 'package:flutter/material.dart';
import 'package:portal/features/submissions/domain/entities/submission/submission.dart';

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

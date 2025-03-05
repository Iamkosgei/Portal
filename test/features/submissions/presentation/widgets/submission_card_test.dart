import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal/features/submissions/domain/entities/submission/submission.dart';
import 'package:portal/features/submissions/presentation/widgets/submission_card.dart';

void main() {
  final testSubmission = Submission(
    id: '1',
    questionId: 'question1',
    question: 'What is Flutter?',
    submittedAnswer: 'A UI toolkit',
    correctAnswer: 'A UI toolkit',
    totalMarks: 10,
  );

  final testIncorrectSubmission = Submission(
    id: '2',
    questionId: 'question2',
    question: 'What is Dart?',
    submittedAnswer: 'A programming language',
    correctAnswer: 'A modern programming language',
    totalMarks: 0,
  );

  Widget createWidgetUnderTest({Submission? submission}) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SubmissionCard(
            submission: submission ?? testSubmission,
          ),
        ),
      ),
    );
  }

  testWidgets('renders correct submission details',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('What is Flutter?'), findsOneWidget);
    expect(find.text('Your Answer: A UI toolkit'), findsOneWidget);
    expect(find.text('Marks: 10'), findsOneWidget);
    expect(find.text('Correct'), findsOneWidget);
  });

  testWidgets('renders incorrect submission with correct answer',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(
      submission: testIncorrectSubmission,
    ));
    await tester.pumpAndSettle();

    expect(find.text('What is Dart?'), findsOneWidget);
    expect(find.text('Your Answer: A programming language'), findsOneWidget);
    expect(find.text('Correct Answer: A modern programming language'),
        findsOneWidget);
    expect(find.text('Marks: 0'), findsOneWidget);
    expect(find.text('Wrong'), findsOneWidget);
  });

  testWidgets('displays correct styling for correct submission',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('Correct'),
            matching: find.byType(Container),
          )
          .first,
    );
    expect(container.decoration, isA<BoxDecoration>());

    final text = tester.widget<Text>(find.text('Correct'));
    expect(text.style?.color, Colors.green);
  });

  testWidgets('displays correct styling for incorrect submission',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(
      submission: testIncorrectSubmission,
    ));
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('Wrong'),
            matching: find.byType(Container),
          )
          .first,
    );
    expect(container.decoration, isA<BoxDecoration>());

    final text = tester.widget<Text>(find.text('Wrong'));
    expect(text.style?.color, Colors.red);
  });

  testWidgets('has correct layout structure', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(Container), findsAtLeastNWidgets(1));
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsAtLeastNWidgets(3));
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portal/features/questions/domain/entities/option/option.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/presentation/bloc/delete_question/delete_question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/question/question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/question/question_state.dart';
import 'package:portal/features/questions/presentation/widgets/question_card.dart';

import 'question_card_test.mocks.dart';

@GenerateMocks([DeleteQuestionCubit, QuestionCubit])
void main() {
  late MockDeleteQuestionCubit mockDeleteQuestionCubit;
  late MockQuestionCubit mockQuestionCubit;

  setUp(() {
    mockDeleteQuestionCubit = MockDeleteQuestionCubit();
    mockQuestionCubit = MockQuestionCubit();

    when(mockDeleteQuestionCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([false]),
    );
    when(mockDeleteQuestionCubit.state).thenReturn(false);

    when(mockQuestionCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const QuestionState.initial(),
      ]),
    );
    when(mockQuestionCubit.state).thenReturn(const QuestionState.initial());
  });

  final testQuestion = Question(
    id: '1',
    questionText: 'What is Flutter?',
    difficulty: DifficultyLevel.medium,
    options: [
      Option(
        id: '1',
        questionId: '1',
        optionText: 'A UI toolkit',
        isCorrect: true,
      ),
      Option(
        id: '2',
        questionId: '1',
        optionText: 'A database',
        isCorrect: false,
      ),
    ],
  );

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DeleteQuestionCubit>(
            create: (context) => mockDeleteQuestionCubit,
          ),
          BlocProvider<QuestionCubit>(
            create: (context) => mockQuestionCubit,
          ),
        ],
        child: Scaffold(
          body: Center(
            child: QuestionCard(
              question: testQuestion,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('renders question card correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('What is Flutter?'), findsOneWidget);
    expect(find.text('2 choices'), findsOneWidget);
    expect(find.text('medium'), findsOneWidget);
  });

  testWidgets('shows delete confirmation dialog when delete button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(find.text('Delete Question'), findsOneWidget);
    expect(find.text('Are you sure you want to delete this question?'),
        findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('calls deleteQuestion when delete is confirmed',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    verify(mockDeleteQuestionCubit.deleteQuestion('1')).called(1);
  });

  testWidgets('displays difficulty level with correct color',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('medium'),
            matching: find.byType(Container),
          )
          .first,
    );
    expect(container.decoration, isA<BoxDecoration>());

    final text = tester.widget<Text>(find.text('medium'));
    expect(text.style?.color, Colors.orange);
  });

  testWidgets('has correct layout structure', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(Container), findsAtLeastNWidgets(1));
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byType(Row), findsAtLeastNWidgets(1));
    expect(find.byType(Text), findsAtLeastNWidgets(3));
  });
}

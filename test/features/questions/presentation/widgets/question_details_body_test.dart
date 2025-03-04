import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portal/features/questions/domain/entities/option/option.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/presentation/bloc/question_details/question_details_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/question_details/question_details_state.dart';
import 'package:portal/features/questions/presentation/widgets/question_details_body.dart';

import 'question_details_body_test.mocks.dart';

@GenerateMocks([QuestionDetailsCubit])
void main() {
  late MockQuestionDetailsCubit mockQuestionDetailsCubit;

  setUp(() {
    mockQuestionDetailsCubit = MockQuestionDetailsCubit();
    when(mockQuestionDetailsCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const QuestionDetailsState.initial(),
      ]),
    );
    when(mockQuestionDetailsCubit.state)
        .thenReturn(const QuestionDetailsState.initial());
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
      Option(
        id: '3',
        questionId: '1',
        optionText: 'A programming language',
        isCorrect: false,
      ),
    ],
  );

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<QuestionDetailsCubit>(
        create: (context) => mockQuestionDetailsCubit,
        child: Material(
          child: QuestionDetailsBody(question: testQuestion),
        ),
      ),
    );
  }

  testWidgets('renders question details correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('What is Flutter?'), findsOneWidget);
    expect(find.text('A UI toolkit'), findsOneWidget);
    expect(find.text('A database'), findsOneWidget);
    expect(find.text('A programming language'), findsOneWidget);
    expect(find.text('MEDIUM'), findsOneWidget);
  });

  testWidgets('selects an option and shows it as selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Initially no option should be selected
    expect(
        tester
            .widget<RadioListTile<String>>(
                find.byType(RadioListTile<String>).first)
            .groupValue,
        null);

    // Select the first option
    await tester.tap(find.byType(RadioListTile<String>).first);
    await tester.pumpAndSettle();

    // Verify the first option is selected
    expect(
        tester
            .widget<RadioListTile<String>>(
                find.byType(RadioListTile<String>).first)
            .groupValue,
        '1');
  });

  testWidgets('displays difficulty level with correct color',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('MEDIUM'),
            matching: find.byType(Container),
          )
          .first,
    );
    expect(container.decoration, isA<BoxDecoration>());

    final text = tester.widget<Text>(find.text('MEDIUM'));
    expect(text.style?.color, Colors.orange);
  });

  testWidgets('shows validation error when submitting without selection',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(find.text('Please select one option!'), findsOneWidget);
  });

  testWidgets('validates answer when option is selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(RadioListTile<String>).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    verify(mockQuestionDetailsCubit.validateAnswer(testQuestion, '1'))
        .called(1);
  });

  testWidgets('all options are rendered as radio list tiles',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.byType(RadioListTile<String>), findsNWidgets(3));
    expect(find.byType(Card), findsNWidgets(3)); // One card per option
  });
}

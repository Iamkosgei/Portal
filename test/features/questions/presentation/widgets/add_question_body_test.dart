import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portal/features/questions/domain/entities/option/option.dart';
import 'package:portal/features/questions/domain/entities/question/question.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_cubit.dart';
import 'package:portal/features/questions/presentation/bloc/add_question/add_question_state.dart';
import 'package:portal/features/questions/presentation/widgets/add_question_body.dart';

import 'add_question_body_test.mocks.dart';

@GenerateMocks([AddQuestionCubit])
void main() {
  late MockAddQuestionCubit mockAddQuestionCubit;

  setUp(() {
    mockAddQuestionCubit = MockAddQuestionCubit();
    when(mockAddQuestionCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const AddQuestionState.initial(),
      ]),
    );
    when(mockAddQuestionCubit.state)
        .thenReturn(const AddQuestionState.initial());
  });

  final testQuestion = Question(
    id: '1',
    questionText: 'What is Flutter?',
    difficulty: DifficultyLevel.easy,
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

  Widget createWidgetUnderTest({Question? initialQuestion}) {
    return MaterialApp(
      home: BlocProvider<AddQuestionCubit>(
        create: (context) => mockAddQuestionCubit,
        child: Scaffold(
          body: SizedBox(
            width: 800,
            height: 1200,
            child: AddQuestionBody(initialQuestion: initialQuestion),
          ),
        ),
      ),
    );
  }

  testWidgets('renders empty form when no initial question is provided',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Create New Question'), findsOneWidget);
    expect(
        find.byType(TextFormField), findsNWidgets(5)); // 1 question + 4 options
    expect(find.byType(Radio<int>), findsNWidgets(4));
    expect(find.text('Save Question'), findsOneWidget);
  });

  testWidgets('renders form with initial question data',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester
        .pumpWidget(createWidgetUnderTest(initialQuestion: testQuestion));
    await tester.pumpAndSettle();

    expect(find.text('Edit Question'), findsOneWidget);
    expect(find.text('What is Flutter?'), findsOneWidget);
    expect(find.text('A UI toolkit'), findsOneWidget);
    expect(find.text('A database'), findsOneWidget);
    expect(find.text('Update Question'), findsOneWidget);
  });

  testWidgets('validates form before submission', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text('Save Question'),
      find.byType(SingleChildScrollView),
      const Offset(0, 50),
    );
    await tester.tap(find.text('Save Question'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a question'), findsOneWidget);
    expect(find.text('Please enter an option'), findsNWidgets(4));
    verifyNever(mockAddQuestionCubit.createQuestion(any));
  });

  testWidgets('adds new option when add button is tapped',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final initialOptionCount =
        tester.widgetList<TextFormField>(find.byType(TextFormField)).length;

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(tester.widgetList<TextFormField>(find.byType(TextFormField)).length,
        initialOptionCount + 1);
  });

  testWidgets('removes option when remove button is tapped',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final initialOptionCount =
        tester.widgetList<TextFormField>(find.byType(TextFormField)).length;

    await tester.tap(find.byIcon(Icons.remove_circle).first);
    await tester.pumpAndSettle();

    expect(tester.widgetList<TextFormField>(find.byType(TextFormField)).length,
        initialOptionCount - 1);
  });

  testWidgets('submits form with valid data', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Fill in question
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Question Text'),
      'What is Flutter?',
    );
    await tester.pump();

    // Fill in options
    final optionFields = find
        .byType(TextFormField)
        .evaluate()
        .skip(1)
        .take(4)
        .toList(); // Skip question field

    await tester.enterText(find.byWidget(optionFields[0].widget), 'Option 1');
    await tester.pump();
    await tester.enterText(find.byWidget(optionFields[1].widget), 'Option 2');
    await tester.pump();
    await tester.enterText(find.byWidget(optionFields[2].widget), 'Option 3');
    await tester.pump();
    await tester.enterText(find.byWidget(optionFields[3].widget), 'Option 4');
    await tester.pump();

    // Select correct answer
    await tester.tap(find.byType(Radio<int>).first);
    await tester.pump();

    // Submit form
    await tester.tap(find.text('Save Question'));
    await tester.pump();

    verify(mockAddQuestionCubit.createQuestion(any)).called(1);
  });

  testWidgets('changes difficulty level', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.byType(DropdownButtonFormField<DifficultyLevel>),
      find.byType(SingleChildScrollView),
      const Offset(0, 50),
    );
    await tester.tap(find.byType(DropdownButtonFormField<DifficultyLevel>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Hard').last);
    await tester.pumpAndSettle();

    expect(find.text('Hard'), findsOneWidget);
  });
}

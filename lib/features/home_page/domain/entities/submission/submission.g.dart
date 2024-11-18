// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubmissionImpl _$$SubmissionImplFromJson(Map<String, dynamic> json) =>
    _$SubmissionImpl(
      id: json['id'] as String,
      questionId: json['questionId'] as String,
      question: json['question'] as String,
      submittedAnswer: json['submittedAnswer'] as String,
      totalMarks: (json['totalMarks'] as num).toInt(),
      correctAnswer: json['correctAnswer'] as String,
    );

Map<String, dynamic> _$$SubmissionImplToJson(_$SubmissionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'question': instance.question,
      'submittedAnswer': instance.submittedAnswer,
      'totalMarks': instance.totalMarks,
      'correctAnswer': instance.correctAnswer,
    };

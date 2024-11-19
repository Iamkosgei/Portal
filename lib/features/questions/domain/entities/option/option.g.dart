// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OptionImpl _$$OptionImplFromJson(Map<String, dynamic> json) => _$OptionImpl(
      id: json['id'] as String,
      questionId: json['questionId'] as String,
      optionText: json['optionText'] as String,
      isCorrect: json['isCorrect'] as bool,
    );

Map<String, dynamic> _$$OptionImplToJson(_$OptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'optionText': instance.optionText,
      'isCorrect': instance.isCorrect,
    };

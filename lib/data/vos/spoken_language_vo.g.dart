// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoken_language_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpokenLanguageVO _$SpokenLanguageVOFromJson(Map<String, dynamic> json) =>
    SpokenLanguageVO(
      json['english_name'] as String?,
      json['iso_639_1'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$SpokenLanguageVOToJson(SpokenLanguageVO instance) =>
    <String, dynamic>{
      'english_name': instance.englishName,
      'iso_639_1': instance.iso6391,
      'name': instance.name,
    };

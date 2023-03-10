// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_actor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetActorResponse _$GetActorResponseFromJson(Map<String, dynamic> json) =>
    GetActorResponse(
      (json['results'] as List<dynamic>?)
          ?.map((e) => ActorVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetActorResponseToJson(GetActorResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

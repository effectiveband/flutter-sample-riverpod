// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_mapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMapper _$ResponseMapperFromJson(Map<String, dynamic> json) =>
    ResponseMapper(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: (json['articles'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ResponseMapperToJson(ResponseMapper instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

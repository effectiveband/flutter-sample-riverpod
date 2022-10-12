import 'package:json_annotation/json_annotation.dart';

part 'response_mapper.g.dart';

@JsonSerializable()
class ResponseMapper {
  final String status;
  final int totalResults;
  final List<Map<String, dynamic>> articles;

  ResponseMapper({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ResponseMapper.fromJson(Map<String, dynamic> json) =>
      _$ResponseMapperFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMapperToJson(this);
}

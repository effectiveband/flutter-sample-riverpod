import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  @JsonKey(name: 'urlToImage')
  final String? imageUrl;
  @JsonKey(name: 'publishedAt')
  final DateTime publishDate;
  final String? content;

  News({
    required this.source,
    this.author,
    required this.title,
    required this.description,
    required this.url,
    this.imageUrl,
    required this.publishDate,
    this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class Source {
  final String? id;
  final String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

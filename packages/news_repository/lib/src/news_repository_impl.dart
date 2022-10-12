import 'package:news_repository/src/models/news.dart';
import 'package:news_repository/src/news_repository.dart';
import 'package:api_client/api_client.dart';

enum _NewsEndpoint {
  everything('everything'),
  topHeadlines('top-headlines');

  const _NewsEndpoint(this.endpoint);

  final String endpoint;
}

class NewsRepositoryImpl implements NewsRepository {
  final ApiClient _apiClient;
  final String apiKey;
  final String localeCode;

  NewsRepositoryImpl({
    required ApiClient apiClient,
    required this.apiKey,
    required this.localeCode,
  })  : assert(apiKey.isNotEmpty, 'Api key must not be empty'),
        _apiClient = apiClient;

  @override
  Future<List<News>> fetchTopHeadlines() async {
    final response = await _apiClient.dio.get(
      _NewsEndpoint.topHeadlines.endpoint,
      queryParameters: {'apiKey': apiKey, 'country': localeCode},
    );

    final result = ResponseMapper.fromJson(response.data);
    final List<News> news = [];
    for (final rawNews in result.articles) {
      news.add(News.fromJson(rawNews));
    }

    return news;
  }

  @override
  Future<List<News>> fetchEverything({required String query}) async {
    final response = await _apiClient.dio.get(
      _NewsEndpoint.everything.endpoint,
      queryParameters: {'apiKey': apiKey, 'q': query},
    );

    final result = ResponseMapper.fromJson(response.data);
    final List<News> news = [];
    for (final rawNews in result.articles) {
      news.add(News.fromJson(rawNews));
    }

    return news;
  }
}

import 'package:news_repository/src/models/news.dart';

abstract class NewsRepository {
  Future<List<News>> fetchTopHeadlines();

  Future<List<News>> fetchEverything({required String query});
}

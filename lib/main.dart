import 'package:api_client/api_client.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_bloc/src/app.dart';
import 'package:flutter_sample_bloc/src/app_settings.dart';
import 'package:news_repository/news_repository.dart';

final _baseUrlProvider = Provider((ref) => dotenv.env['BASE_URL']!);
final _apiKeyProvider = Provider((ref) => dotenv.env['API_KEY']!);

final _dioProvider = Provider((ref) {
  final baseUrl = ref.watch(_baseUrlProvider);
  return ApiClient(baseUrl: baseUrl);
});
final newsRepositoryProvider = Provider((ref) {
  final apiKey = ref.watch(_apiKeyProvider);
  final apiClient = ref.watch(_dioProvider);

  return NewsRepositoryImpl(
    apiClient: apiClient,
    apiKey: apiKey,
    localeCode: defaultLocaleName,
  );
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  runApp(const ProviderScope(child: App()));
}

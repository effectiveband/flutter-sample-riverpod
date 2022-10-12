import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_bloc/main.dart';
import 'package:flutter_sample_bloc/src/features/news/view/widgets/news_card.dart';
import 'package:flutter_sample_bloc/src/theme/theme.dart';
import 'package:flutter_sample_bloc/src/theme/ui/error_widget.dart';
import 'package:flutter_sample_bloc/src/theme/ui/news_progress_indicator.dart';

final newsProvider = FutureProvider((ref) async {
  final newsRepository = ref.watch(newsRepositoryProvider);

  final news = await newsRepository.fetchTopHeadlines();
  return news;
});

class NewsPage extends ConsumerWidget {
  static const routeName = '/news';

  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsData = ref.watch(newsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
      ),
      body: newsData.when(
        loading: () => const NewsProgressIndicator(),
        error: (err, stack) => const NetworkErrorWidget(),
        data: (news) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref.refresh(newsProvider.future);
            },
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(defaultListPaddingValue),
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return NewsCard(news: news[index]);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

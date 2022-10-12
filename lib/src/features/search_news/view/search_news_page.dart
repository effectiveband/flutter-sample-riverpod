import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_bloc/main.dart';
import 'package:flutter_sample_bloc/src/features/news/view/widgets/news_card.dart';
import 'package:flutter_sample_bloc/src/features/search_news/view/widgets/search_news_bar.dart';
import 'package:flutter_sample_bloc/src/theme/ui/news_progress_indicator.dart';
import 'package:flutter_sample_bloc/src/theme/ui/sliver_with_max_constraints.dart';
import 'package:flutter_sample_bloc/src/theme/ui/sliver_without_scroll_body.dart';
import 'package:flutter_sample_bloc/src/theme/ui/error_widget.dart';
import 'package:news_repository/news_repository.dart';

final searchValueProvider = StateProvider((ref) => '');

final searchNewsProvider = FutureProvider<List<News>>((ref) async {
  final newsRepository = ref.watch(newsRepositoryProvider);
  final search = ref.watch(searchValueProvider);

  if (search.isEmpty) {
    return [];
  }
  final news = await newsRepository.fetchEverything(query: search);
  return news;
});

class SearchNewsPage extends ConsumerWidget {
  const SearchNewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsData = ref.watch(searchNewsProvider);
    final searchValue = ref.watch(searchValueProvider.notifier);

    return Scaffold(
      body: RefreshIndicator(
        displacement: 110,
        onRefresh: () async {
          await ref.refresh(searchNewsProvider.future);
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                title: SearchNewsBar(
                  onChanged: (value) {
                    searchValue.state = value;
                  },
                ),
                floating: true,
              ),
              newsData.when(
                loading: () => const SliverWithoutScrollBody(
                  child: NewsProgressIndicator(),
                ),
                error: (error, stackTrace) => const SliverWithoutScrollBody(
                  child: NetworkErrorWidget(),
                ),
                data: (news) {
                  if (searchValue.state.isEmpty) {
                    return const SliverWithoutScrollBody(
                      child: Center(
                        child: Text('Enter the query to search'),
                      ),
                    );
                  }
                  if (news.isEmpty) {
                    return const SliverWithoutScrollBody(
                      child: Center(
                        child: Text('Nothing found'),
                      ),
                    );
                  }
                  return SliverWithMaxConstraints(
                    maxWidth: 500,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: news.length,
                        (context, index) {
                          return NewsCard(news: news[index]);
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

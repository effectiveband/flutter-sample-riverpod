import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample_bloc/src/features/news/view/widgets/news_image.dart';
import 'package:news_repository/news_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

final selectedNewsProvider =
    Provider<News>((ref) => throw UnimplementedError());

final launchUrlProvider =
    FutureProvider.autoDispose.family<bool, String>((ref, url) async {
  if (!await canLaunchUrlString(url)) {
    return false;
  }
  launchUrlString(
    url,
    mode: Platform.isIOS
        ? LaunchMode.platformDefault
        : LaunchMode.externalApplication,
  );
  return true;
});

class DetailedNewsPage extends ConsumerWidget {
  static const routeName = '/detailed-news';

  const DetailedNewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(selectedNewsProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.link),
        onPressed: () {
          final isLaunched = ref.read(launchUrlProvider(news.url));
          if (isLaunched.value == null && !isLaunched.value!) {
            const snackBar = SnackBar(
              backgroundColor: Colors.grey,
              content: Text('Can not launch url!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SafeArea(
            top: news.imageUrl == null,
            child: CustomScrollView(
              slivers: [
                if (news.imageUrl != null)
                  SliverAppBar(
                    stretch: true,
                    floating: true,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: NewsImage(
                        imageUrl: news.imageUrl!,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16.0),
                        ),
                      ),
                      stretchModes: const [StretchMode.zoomBackground],
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      news.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                if (news.description != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        news.description!,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                if (news.content != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(news.content!),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

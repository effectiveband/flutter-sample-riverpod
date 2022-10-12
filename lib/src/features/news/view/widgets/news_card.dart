import 'package:flutter/material.dart';
import 'package:flutter_sample_bloc/src/extensions/timeago_extension.dart';
import 'package:flutter_sample_bloc/src/features/detailed_news/view/detailed_news_page.dart';
import 'package:flutter_sample_bloc/src/features/detailed_news/view/detailed_news_page_args.dart';
import 'package:flutter_sample_bloc/src/features/news/view/widgets/news_image.dart';
import 'package:news_repository/news_repository.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        DetailedNewsPage.routeName,
        arguments: DetailedNewsPageArgs(news: news),
      ),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl != null) NewsImage(imageUrl: news.imageUrl!),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                news.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  text: news.author ?? news.publishDate.timeAgo(),
                  children: news.author != null
                      ? [
                          const TextSpan(text: ' \u2022 '),
                          TextSpan(text: news.publishDate.timeAgo())
                        ]
                      : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

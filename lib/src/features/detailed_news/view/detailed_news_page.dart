import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_bloc/src/features/detailed_news/bloc/detailed_news_bloc.dart';
import 'package:flutter_sample_bloc/src/features/news/view/widgets/news_image.dart';

class DetailedNewsPage extends StatelessWidget {
  static const routeName = '/detailed-news';

  const DetailedNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.link),
        onPressed: () =>
            context.read<DetailedNewsBloc>()..add(DetailedNewsLinkLaunched()),
      ),
      body: BlocConsumer<DetailedNewsBloc, DetailedNewsState>(
        listener: (context, state) {
          if (state is DetailedNewsLaunchLinkFailure) {
            const snackBar = SnackBar(
              backgroundColor: Colors.grey,
              content: Text('Can not launch url!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          final news = context.read<DetailedNewsBloc>().news;
          return Center(
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
          );
        },
      ),
    );
  }
}

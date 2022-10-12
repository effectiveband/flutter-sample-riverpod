import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_repository/news_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'detailed_news_event.dart';
part 'detailed_news_state.dart';

class DetailedNewsBloc extends Bloc<DetailedNewsEvent, DetailedNewsState> {
  final News news;

  DetailedNewsBloc({required this.news}) : super(DetailedNewsInitial()) {
    on<DetailedNewsEvent>(_onDetailedNewsLinkLaunched);
  }

  void _onDetailedNewsLinkLaunched(
    DetailedNewsEvent event,
    Emitter<DetailedNewsState> emit,
  ) async {
    final url = news.url;
    if (!await canLaunchUrlString(url)) {
      return emit(DetailedNewsLaunchLinkFailure());
    }
    launchUrlString(
      url,
      mode: Platform.isIOS
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
    return emit(DetailedNewsLaunchLinkSuccess());
  }
}

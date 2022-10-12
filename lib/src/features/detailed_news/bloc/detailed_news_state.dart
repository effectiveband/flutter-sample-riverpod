part of 'detailed_news_bloc.dart';

@immutable
abstract class DetailedNewsState {}

class DetailedNewsInitial extends DetailedNewsState {}

class DetailedNewsLaunchLinkFailure extends DetailedNewsState {}

class DetailedNewsLaunchLinkSuccess extends DetailedNewsState {}

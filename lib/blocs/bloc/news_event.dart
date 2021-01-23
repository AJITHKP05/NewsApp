part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class NewsEventLoad extends NewsEvent {
  final String filter;

  NewsEventLoad(this.filter);
}

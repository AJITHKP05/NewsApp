part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class Error extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> list;

  NewsLoaded(this.list);
}

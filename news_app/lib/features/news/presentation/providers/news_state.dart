import 'package:news_app/features/news/domain/entities/news_entity.dart';

class NewsState {
  final List<News> news;
  final List<News> savedNews;
  final bool isLoading;
  final int currentPage;

  NewsState({
    required this.news,
    required this.savedNews,
    required this.isLoading,
    required this.currentPage,
  });

  factory NewsState.initial() {
    return NewsState(
      news: [],
      savedNews: [],
      isLoading: false,
      currentPage: 1,
    );
  }

  NewsState copyWith({
    List<News>? news,
    List<News>? savedNews,
    bool? isLoading,
    int? currentPage,
  }) {
    return NewsState(
      news: news ?? this.news,
      savedNews: savedNews ?? this.savedNews,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
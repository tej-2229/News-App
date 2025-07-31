import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/usecases/get_news.dart';
import 'package:news_app/features/news/domain/usecases/get_saved_news.dart';
import 'package:news_app/features/news/domain/usecases/remove_news.dart';
import 'package:news_app/features/news/domain/usecases/save_news.dart';
import 'package:news_app/features/news/presentation/providers/news_state.dart';

class NewsNotifier extends StateNotifier<NewsState> {
  final GetNews getNews;
  final GetSavedNews getSavedNews;
  final SaveNews saveNews;
  final RemoveNews removeNews;

  NewsNotifier({
    required this.getNews,
    required this.getSavedNews,
    required this.saveNews,
    required this.removeNews,
  }) : super(NewsState.initial());

  Future<void> fetchNews({int page = 1}) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final result = await getNews(page: page);
      state = state.copyWith(
        news: [...state.news, ...result],
        isLoading: false,
        currentPage: page,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> refreshNews() async {
    state = state.copyWith(isLoading: true);
    final result = await getNews(page: 1);
    state = NewsState(
      news: result,
      isLoading: false,
      currentPage: 1,
      savedNews: state.savedNews,
    );
  }

  Future<void> loadSavedNews() async {
    final result = await getSavedNews();
    state = state.copyWith(savedNews: result);
  }

  Future<void> toggleSaveNews(News news) async {
    final isSaved = state.savedNews.any((n) => n.articleId == news.articleId);
    if (isSaved) {
      await removeNews(news.articleId);
    } else {
      await saveNews(news);
    }
    await loadSavedNews();
  }
}
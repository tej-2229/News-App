import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class GetSavedNews {
  final NewsRepository repository;

  GetSavedNews(this.repository);

  Future<List<News>> call() async {
    return await repository.getSavedNews();
  }
}
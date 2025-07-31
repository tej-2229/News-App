import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class SaveNews {
  final NewsRepository repository;

  SaveNews(this.repository);

  Future<void> call(News news) async {
    await repository.saveNews(news);
  }
}
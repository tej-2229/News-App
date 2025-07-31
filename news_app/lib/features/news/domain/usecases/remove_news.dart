import 'package:news_app/features/news/domain/repositories/news_repository.dart';

class RemoveNews {
  final NewsRepository repository;

  RemoveNews(this.repository);

  Future<void> call(String articleId) async {
    await repository.removeNews(articleId);
  }
}
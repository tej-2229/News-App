import 'package:news_app/features/news/domain/entities/news_entity.dart';

class NewsModel extends News {
  const NewsModel({
    required super.articleId,
    required super.title,
    required super.link,
    required super.creator,
    required super.description,
    required super.content,
    required super.pubDate,
    required super.imageUrl,
    required super.sourceId,
    required super.sourceName,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      articleId: json['article_id'] ?? '',
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      creator: json['creator'] != null
          ? List<String>.from(json['creator'])
          : null,
      description: json['description'],
      content: json['content'],
      pubDate: json['pubDate'] ?? '',
      imageUrl: json['image_url'],
      sourceId: json['source_id'] ?? '',
      sourceName: json['source_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'link': link,
      'creator': creator,
      'description': description,
      'content': content,
      'pubDate': pubDate,
      'image_url': imageUrl,
      'source_id': sourceId,
      'source_name': sourceName,
    };
  }

  factory NewsModel.fromEntity(News news) {
    return NewsModel(
      articleId: news.articleId,
      title: news.title,
      link: news.link,
      creator: news.creator,
      description: news.description,
      content: news.content,
      pubDate: news.pubDate,
      imageUrl: news.imageUrl,
      sourceId: news.sourceId,
      sourceName: news.sourceName,
    );
  }
}



import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/presentation/view/home_view.dart';
import 'package:news_app/features/news/presentation/view/article_detail_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: 'article/:id',
          builder: (context, state) {
            final news = state.extra as News;
            return ArticleDetailView(news: news);
          },
        ),
      ],
    ),
  ],
);
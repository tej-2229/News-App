import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/theme/theme_provider.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/presentation/providers/news_provider.dart';
import 'package:news_app/features/news/presentation/widgets/news_list.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsProvider.notifier).fetchNews();
      ref.read(newsProvider.notifier).loadSavedNews();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final currentPage = ref.read(newsProvider).currentPage;
      ref.read(newsProvider.notifier).fetchNews(page: currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final state = ref.watch(newsProvider);
    final notifier = ref.read(newsProvider.notifier);

    List<News> filteredNews = state.news;
    if (_searchController.text.isNotEmpty) {
      filteredNews = state.news.where((news) {
        final title = news.title.toLowerCase();
        final content = news.content?.toLowerCase() ?? '';
        final searchTerm = _searchController.text.toLowerCase();
        return title.contains(searchTerm) || content.contains(searchTerm);
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: Icon(theme.brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => notifier.refreshNews(),
              child: NewsList(
                scrollController: _scrollController,
                news: filteredNews,
                savedNews: state.savedNews,
                isLoading: state.isLoading,
                onTap: (news) {
                  context.push('/article/${news.articleId}', extra: news);
                },
                onSave: (news) {
                  notifier.toggleSaveNews(news);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
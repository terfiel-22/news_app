import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatefulWidget {
  const DailyNews({super.key});

  @override
  State<DailyNews> createState() => _DailyNewsState();
}

class _DailyNewsState extends State<DailyNews> {
  Future<void> _refreshArticles() async {
    context.read<RemoteArticleBloc>().add(const GetArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Daily News'),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, state) {
      if (state is RemoteArticlesLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is RemoteArticlesError) {
        return Center(
          child: IconButton(
            onPressed: _refreshArticles,
            icon: Icon(
              Icons.refresh,
              size: 50,
            ),
          ),
        );
      }

      if (state is RemoteArticlesDone) {
        return RefreshIndicator(
          onRefresh: _refreshArticles,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final article = state.articles![index];
              return ArticleTile(article: article);
            },
            itemCount: state.articles?.length,
          ),
        );
      }

      return SizedBox();
    });
  }
}

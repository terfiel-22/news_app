import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

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
        return const Center(
          child: Icon(Icons.refresh),
        );
      }

      if (state is RemoteArticlesDone) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final article = state.articles![index];
            return ArticleTile(article: article);
          },
          itemCount: state.articles?.length,
        );
      }

      return SizedBox();
    });
  }
}

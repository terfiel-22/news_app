import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';

class SavedArticles extends StatelessWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
        builder: (_, state) {
      if (state is LocalArticlesLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is LocalArticlesDone) {
        if (state.articles!.isEmpty) {
          return Center(
            child: Text(
              'No saved articles',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            final article = state.articles![index];
            return ArticleTile(
              article: article,
              isRemovable: true,
            );
          },
          itemCount: state.articles!.length,
        );
      }

      return SizedBox();
    });
  }
}

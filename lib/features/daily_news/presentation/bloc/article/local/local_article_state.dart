import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final ArticleEntity? article;

  const LocalArticleState({this.articles, this.article});

  @override
  List<Object?> get props => [articles, article];
}

class LocalArticlesLoading extends LocalArticleState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticleState {
  const LocalArticlesDone(List<ArticleEntity> articles)
      : super(articles: articles);
}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(ArticleEntity? article) : super(article: article);
}

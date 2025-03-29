import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticleEvent extends Equatable {
  final ArticleEntity? article;
  final String? url;

  const LocalArticleEvent({this.article, this.url});

  @override
  List<Object?> get props => [article];
}

class GetSavedArticles extends LocalArticleEvent {
  const GetSavedArticles();
}

class RemoveArticle extends LocalArticleEvent {
  const RemoveArticle(ArticleEntity article) : super(article: article);
}

class SaveArticle extends LocalArticleEvent {
  const SaveArticle(ArticleEntity article) : super(article: article);
}

class GetArticleByUrl extends LocalArticleEvent {
  const GetArticleByUrl(String url) : super(url: url);
}

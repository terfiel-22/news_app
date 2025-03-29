import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/data/models/article_model.dart';

@dao
abstract class ArticleDao {
  @insert
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query('SELECT * FROM articles')
  Future<List<ArticleModel>> getArticles();
}

import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleResponseModel {
  List<ArticleModel> articles;

  ArticleResponseModel({required this.articles});

  factory ArticleResponseModel.fromJson(
      Map<String, dynamic> articleResponseData) {
    return ArticleResponseModel(
      articles: ((articleResponseData['articles'] ?? []) as List<dynamic>)
          .map(
            (dynamic article) => ArticleModel.fromJson(article),
          )
          .toList(),
    );
  }
}

@Entity(tableName: 'articles', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.id,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '',
    );
  }
}

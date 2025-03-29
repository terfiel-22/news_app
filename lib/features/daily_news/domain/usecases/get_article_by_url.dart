import 'package:news_app/core/usecases/use_case.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleByUrlUseCase implements UseCase<ArticleEntity?, String> {
  final ArticleRepository _articleRepository;
  GetSavedArticleByUrlUseCase(this._articleRepository);

  @override
  Future<ArticleEntity?> call({String? params}) {
    return _articleRepository.getArticleByUrl(params!);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article_by_url.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final GetSavedArticleByUrlUseCase _getArticleByUrl;

  LocalArticleBloc(
    this._getSavedArticleUseCase,
    this._saveArticleUseCase,
    this._removeArticleUseCase,
    this._getArticleByUrl,
  ) : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
    on<GetArticleByUrl>(onGetArticleByUrl);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticleUseCase();

    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(
    RemoveArticle removeArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(
    SaveArticle saveArticle,
    Emitter<LocalArticleState> emit,
  ) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onGetArticleByUrl(
    GetArticleByUrl event,
    Emitter<LocalArticleState> emit,
  ) async {
    final article = await _getArticleByUrl(params: event.url);
    emit(LocalArticleDone(article));
  }
}

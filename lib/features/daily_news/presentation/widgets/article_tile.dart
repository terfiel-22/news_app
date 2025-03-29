import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/util/snackbar_util.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_detail/article_detail.dart';

class ArticleTile extends StatefulWidget {
  final ArticleEntity article;
  final bool isRemovable;

  const ArticleTile(
      {super.key, required this.article, this.isRemovable = false});

  @override
  State<ArticleTile> createState() => _ArticleTileState();
}

class _ArticleTileState extends State<ArticleTile> {
  void _viewArticle() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetail(article: widget.article),
      ),
    );
  }

  void _onRemoveArticle() {
    BlocProvider.of<LocalArticleBloc>(context)
        .add(RemoveArticle(widget.article));

    SnackbarUtil.displaySuccessMessage(
        context: context, message: 'Article removed successfully.');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _viewArticle,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cached Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.article.urlToImage ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey),
                ),
              ),
              const SizedBox(width: 10),
              // Title, Description, and Author
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.article.title ?? 'No Title',
                      style: theme.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.article.description ?? 'No Description',
                      style: theme.textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'By ${widget.article.author ?? 'Unknown'}',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              widget.isRemovable ? _buildRemoveButton() : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveButton() {
    return IconButton(
      color: Colors.redAccent,
      icon: Icon(Icons.remove_circle),
      onPressed: _onRemoveArticle,
    );
  }
}

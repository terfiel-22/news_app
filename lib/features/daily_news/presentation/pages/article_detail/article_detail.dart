import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/util/date_format_util.dart';
import 'package:news_app/core/util/snackbar_util.dart';
import 'package:news_app/core/util/url_launcher_util.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_article_event.dart';

class ArticleDetail extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetail({super.key, required this.article});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  void _launchUrl() async {
    bool isLaunchedUrl =
        await UrlLauncherUtil.goToURL(link: widget.article.url!);
    if (!isLaunchedUrl) {
      if (mounted) {
        SnackbarUtil.displayErrorMessage(
            context: context, message: 'Could not launched url.');
      }
    }
  }

  void _onSaveArticle() {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(widget.article));
    SnackbarUtil.displaySuccessMessage(
        context: context, message: 'Article saved successfully.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            if (widget.article.urlToImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.article.urlToImage!,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.broken_image, size: 100),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 16),

            // Title
            Text(
              widget.article.title!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Author & Published Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.article.author!.isNotEmpty
                        ? "By ${widget.article.author}"
                        : "Unknown Author",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700]),
                  ),
                ),
                const SizedBox(width: 30),
                Text(
                  DateFormatUtil.formatDate(widget.article.publishedAt!),
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Description
            if (widget.article.description!.isNotEmpty)
              Text(
                widget.article.description!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

            const SizedBox(height: 12),

            // Content
            if (widget.article.content!.isNotEmpty)
              Text(
                widget.article.content!,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),

            const SizedBox(height: 20),

            // Read More Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _launchUrl(),
                icon: const Icon(Icons.open_in_browser),
                label: const Text("Read Full Article"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSaveArticle,
        child: Icon(Icons.bookmark),
      ),
    );
  }
}

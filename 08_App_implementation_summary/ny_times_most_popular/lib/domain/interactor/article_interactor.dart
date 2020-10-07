import 'package:flutter/foundation.dart';
import 'package:ny_times_most_popular/data/disk/article_disk_data_source.dart';
import 'package:ny_times_most_popular/data/network/article_network_data_source.dart';
import 'package:ny_times_most_popular/domain/model/article.dart';

class ArticleInteractor {
  final ArticleDiskDataSource _articleDiskDataSource;
  final ArticleNetworkDataSource _articleNetworkDataSource;

  ArticleInteractor(
    this._articleDiskDataSource,
    this._articleNetworkDataSource,
  );

  Future<List<Article>> getArticles() async {
    return await _articleDiskDataSource.getAllArticles();
  }

  Future<void> refreshArticles() async {
    debugPrint("Downloading network articles");
    final articles = await _articleNetworkDataSource.getArticles();

    debugPrint("Saving downloaded articles to disk");
    await _articleDiskDataSource.saveArticles(articles);
  }

  Future<Article> getArticleById(int id) async{
    print("Getting article $id from disk");
    return await _articleDiskDataSource.getArticle(id);
  }
}

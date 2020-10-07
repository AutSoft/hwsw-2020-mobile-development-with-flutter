import 'package:ny_times_most_popular/data/network/model/network_article.dart';
import 'package:ny_times_most_popular/domain/model/article.dart';

import 'nyt_api.dart';

class ArticleNetworkDataSource {
  final NytApi _nytApi;

  ArticleNetworkDataSource(this._nytApi);

  Future<List<Article>> getArticles() async {
    final networkResponse = await _nytApi.getArticles();

    if (!networkResponse.isSuccessful) return null;

    final networkArticles = networkResponse.body.results;

    return networkArticles.map((article) => article.toDomainModel()).toList();
  }
}

extension on NetworkArticle {
  Article toDomainModel() {
    final firstImageMetadata = this.media.firstWhere((media) => media.type == "image", orElse: () => null)?.metadata;
    final thumbUrl =
        firstImageMetadata?.firstWhere((media) => media.format == "Standard Thumbnail", orElse: () => null)?.url;
    final largeUrl =
        firstImageMetadata?.firstWhere((media) => media.format == "mediumThreeByTwo440", orElse: () => null)?.url;

    return Article(
      id: this.id,
      url: this.url,
      byLine: this.byline,
      title: this.title,
      publishedDate: this.publishedDate,
      thumbUrl: thumbUrl,
      largeUrl: largeUrl,
    );
  }
}

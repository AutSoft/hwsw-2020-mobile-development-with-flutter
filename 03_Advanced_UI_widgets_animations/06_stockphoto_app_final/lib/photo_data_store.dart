import 'dart:math';

import 'package:lipsum/lipsum.dart' as lipsum;

class StockPhoto {
  static List<StockPhoto> _cache = [];

  factory StockPhoto.fromId(int id){
    while(_cache.length <= id){
      _cache.add(null);
    }
    if (_cache[id] == null){
      _cache[id] = StockPhoto._generate(id);
    }
    return _cache[id];
  }

  final int id;
  final String url;
  final String title;
  final String description;
  final double rating;

  StockPhoto._generate(this.id)
      : this.url = "https://picsum.photos/600/400?$id",
        this.title = lipsum.createWord(numWords: 2),
        this.description = lipsum.createSentence(numSentences: 3),
        this.rating = Random().nextDouble() * 5;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StockPhoto && runtimeType == other.runtimeType && id == other.id && url == other.url && title == other.title && description == other.description && rating == other.rating;

  @override
  int get hashCode => id.hashCode ^ url.hashCode ^ title.hashCode ^ description.hashCode ^ rating.hashCode;
}


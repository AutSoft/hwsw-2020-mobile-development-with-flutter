import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final String uid;
  final String author;
  final String title;
  final String body;
  final String imageUrl;

  Post({
    this.uid,
    this.author,
    this.title,
    this.body,
    this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

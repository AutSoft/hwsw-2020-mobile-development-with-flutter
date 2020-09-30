import 'package:flutter/material.dart';
import 'package:flutter_forum/domain/model/post.dart';

class PostItem extends StatelessWidget {
  Post post;

  PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(post.author),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(post.body),
              ),
              if (post.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Image.network(post.imageUrl),
                )
            ],
          ),
        ),
      ),
    );
  }
}

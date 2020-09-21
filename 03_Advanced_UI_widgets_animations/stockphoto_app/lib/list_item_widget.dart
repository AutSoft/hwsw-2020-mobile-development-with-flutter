import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stockphotoapp/like_button.dart';
import 'package:stockphotoapp/photo_data_store.dart';

import 'detailed_page.dart';

class ListItemWidget extends StatefulWidget {
  final StockPhoto item;

  const ListItemWidget({Key key, this.item}) : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1 / 1,
          child: Image.network(
            widget.item.url,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(widget.item.title),
        subtitle: Text(
          widget.item.description,
          maxLines: 1,
        ),
        trailing: LikeButton(),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailedPage(
                photo: widget.item,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedRotation extends ImplicitlyAnimatedWidget {
  final double angle;
  final Widget child;

  AnimatedRotation({this.angle, this.child, @required Duration duration, @required Curve curve, Key key}) : super(key: key, duration: duration, curve: curve);

  @override
  _AnimatedRotationState createState() => _AnimatedRotationState();
}

class _AnimatedRotationState extends AnimatedWidgetBaseState<AnimatedRotation> {
  Tween<double> _angleTween;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angleTween.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _angleTween = visitor(_angleTween, widget.angle, (dynamic value) => Tween<double>(begin: value));
  }
}

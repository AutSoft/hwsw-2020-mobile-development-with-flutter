import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Downloader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImageDownloaderPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ImageDownloaderPage extends StatefulWidget {
  ImageDownloaderPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImageDownloaderPageState createState() => _ImageDownloaderPageState();
}

class _ImageDownloaderPageState extends State<ImageDownloaderPage> {
  static const IMAGES_DIR = 'images';
  Future<List<File>> _imageFiles;

  @override
  void initState() {
    super.initState();
    // _imageFiles = _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Show images here!"),
      ),
    );
  }
}

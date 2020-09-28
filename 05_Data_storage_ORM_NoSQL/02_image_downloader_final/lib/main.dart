import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

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

  final scrollController = ScrollController(keepScrollOffset: true);

  @override
  void initState() {
    super.initState();
    _imageFiles = _loadImages();
  }

  Future<Directory> _getImagesDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return Directory(path.join(directory.path, IMAGES_DIR)).create();
  }

  void _downloadNewImage() async {
    final response = await http.get("https://picsum.photos/400");
    final imagesDir = await _getImagesDirectory();
    final filePath = path.join(
      imagesDir.path,
      "${DateTime.now().toIso8601String()}.jpg",
    );
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    print("Image downloaded to: $filePath");

    setState(() {
      _imageFiles = _loadImages();
    });
  }

  Future<List<File>> _loadImages() async {
    final imagesDir = await _getImagesDirectory();
    return imagesDir
        .list()
        .where((element) => element.path.endsWith(".jpg"))
        .map((e) => File(e.path))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<File>>(
          future: _imageFiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final imageFiles = snapshot.data;
              return GridView.builder(
                controller: scrollController,
                itemCount: imageFiles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Image.file(imageFiles[index]);
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _downloadNewImage,
        tooltip: 'Download image',
        child: Icon(Icons.file_download),
      ),
    );
  }
}

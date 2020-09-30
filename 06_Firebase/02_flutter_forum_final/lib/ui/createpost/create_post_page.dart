import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forum/domain/model/post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _postTitleController = TextEditingController();
  final _postBodyController = TextEditingController();

  Future<File> _imageFuture;
  File selectedImage;
  final _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFuture = Future.value(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _submitPost(BuildContext context) async {
    // TODO Upload image to Cloud Storage
    String imageUrl;
    if (selectedImage != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final imageName = UriData.fromString(
        "${Uuid().v4()}.jpg",
        encoding: Encoding.getByName("UTF-8"),
      );
      final newImageRef = storageRef.child("images/$imageName");

      newImageRef.putFile(selectedImage).onComplete.then((value) async {
        imageUrl = await newImageRef.getDownloadURL();
        return uploadPost(context, imageUrl);
      });
    } else {
      uploadPost(context);
    }
  }

  Future<void> uploadPost(BuildContext context, [String imageUrl]) {
    // TODO create a new post in the Realtime Database
    final postsRef = FirebaseDatabase.instance.reference().child("posts");
    final key = postsRef.push().key;

    final newPost = Post(
            uid: key,
            title: _postTitleController.text,
            body: _postBodyController.text,
            author: FirebaseAuth.instance.currentUser?.email ?? "Anonymous",
            imageUrl: imageUrl)
        .toJson();

    postsRef.child(key).set(newPost).whenComplete(() => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _postTitleController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: "Title",
              ),
            ),
            TextField(
              controller: _postBodyController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: "Write something nice here",
              ),
            ),
            FutureBuilder(
              future: _imageFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  selectedImage = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.file(selectedImage),
                    ),
                  );
                }

                return Container();
              },
            ),
            RaisedButton(
              onPressed: () {
                _pickImage();
              },
              child: Text("Take a photo".toUpperCase()),
            ),
            RaisedButton(
              onPressed: () {
                _submitPost(context);
              },
              child: Text("Post".toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}

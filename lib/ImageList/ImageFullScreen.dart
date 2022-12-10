import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  final String imageURL;
  const ImageFullScreen({Key? key, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("PixaBay",style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(imageURL),
          ),
        ),
      ),
    );
  }
}

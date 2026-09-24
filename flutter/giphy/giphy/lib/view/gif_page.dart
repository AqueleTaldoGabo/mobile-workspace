import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;
  GifPage(this._gifData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Image.network(
          "https://developers.giphy.com/branch/"
          "master/static/header-logo.gif",
          fit: BoxFit.contain,
          height: 40,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
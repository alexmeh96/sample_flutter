import 'dart:io';

import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  CameraViewPage({Key? key, required this.path}) : super(key: key);

  String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 150,
        child: Image.file(
          File(path),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}

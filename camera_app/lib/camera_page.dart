import 'package:camera_app/camera_screen.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Camera app",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: const CameraScreen(),
    );
  }
}

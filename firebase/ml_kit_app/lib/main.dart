import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ml_kit_app/face_detection/face_detection_page.dart';

import 'text_recognition/camera_screen.dart';

// Global variable for storing the list of cameras available
List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('CameraError: ${e.description}');
  }
  runApp(
    MaterialApp(
      title: 'Flutter MLKit Vision',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  List<String> itemsList = [
    "Text scanner",
    "Face detection",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Text Recognition'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Face Detection'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FaceDetectionPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

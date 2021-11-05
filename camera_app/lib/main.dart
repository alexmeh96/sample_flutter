import 'package:camera/camera.dart';
import 'package:camera_app/camera_page.dart';
import 'package:camera_app/create_vid.dart';
import 'package:flutter/material.dart';

import 'camera_screen.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const CameraPage(),
    );
  }
}

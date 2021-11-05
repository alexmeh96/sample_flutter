import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;

  const DetailScreen({required this.imagePath});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final String _imagePath;
  late final FaceDetector _faceDetector;
  late final ImageLabeler _imageLabeler;
  Size? _imageSize;
  List<Rect> _elements = [];

  List<String>? _listEmailStrings;

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();
    final Image image = Image.file(imageFile);

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;

    setState(() {
      _imageSize = imageSize;
    });
  }



//   void _recognizeFaces() async {
//     _getImageSize(File(_imagePath));
//
//     // Creating an InputImage object using the image path
//     final inputImage = InputImage.fromFilePath(_imagePath);
// // Retrieving the RecognisedText from the InputImage
//     final faces = await _faceDetector.processImage(inputImage);
//
//     for (Face face in faces) {
//       final Rect boundingBox = face.boundingBox;
//
//       final double? rotY = face.headEulerAngleY; // Head is rotated to the right rotY degrees
//       final double? rotZ = face.headEulerAngleZ; // Head is tilted sideways rotZ degrees
//
//       // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
//       // eyes, cheeks, and nose available):
//       final FaceLandmark? leftEar = face.getLandmark(FaceLandmarkType.leftEar);
//       if (leftEar != null) {
//         final Point<double> leftEarPos = leftEar.position;
//       }
//
//       // If classification was enabled with FaceDetectorOptions:
//       if (face.smilingProbability != null) {
//         final double? smileProb = face.smilingProbability;
//       }
//
//       // If face tracking was enabled with FaceDetectorOptions:
//       if (face.trackingId != null) {
//         final int? id = face.trackingId;
//       }
//     }
//
//   }

  void detectFace() async {

    final inputImage = InputImage.fromFilePath(_imagePath);

    List<Face> faces = await _faceDetector.processImage(inputImage);
    for (Face face in faces) {
      _elements.add(face.boundingBox);
    }
    _getImageSize(File(_imagePath));
  }

  void detectLabel() async {

    final inputImage = InputImage.fromFilePath(_imagePath);

    List<ImageLabel> labels = await _imageLabeler.processImage(inputImage);
    for (ImageLabel label in labels) {
      final String text = label.label;
      final int index = label.index;
      final double confidence = label.confidence;
      print('text: $text; index: $index; confidence: $confidence');
    }
    _getImageSize(File(_imagePath));
  }




  @override
  void initState() {
    _imagePath = widget.imagePath;
    // Initializing the text detector
    _faceDetector = GoogleMlKit.vision.faceDetector();
    _imageLabeler = GoogleMlKit.vision.imageLabeler();
    // detectFace();
    detectLabel();
    super.initState();
  }

  @override
  void dispose() {
    // Disposing the text detector when not used anymore
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Details"),
      ),
      body: _imageSize != null
          ? Stack(
        children: [
          Container(
            width: double.maxFinite,
            color: Colors.black,
            child: CustomPaint(
              foregroundPainter: FacePainter(
                _imageSize!,
                _elements,
              ),
              child: AspectRatio(
                aspectRatio: _imageSize!.aspectRatio,
                child: Image.file(
                  File(_imagePath),
                ),
              ),
            ),
          ),
        ],
      )
          : Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}


class FacePainter extends CustomPainter {

  FacePainter(this.absoluteImageSize, this.elements);

  final Size absoluteImageSize;
  final List<Rect> elements;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(Rect rect) {
      return Rect.fromLTRB(
        rect.left * scaleX,
        rect.top * scaleY,
        rect.right * scaleX,
        rect.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 2.0;

    for (Rect element in elements) {
      canvas.drawRect(scaleRect(element), paint);
    }
  }

  @override
  bool shouldRepaint(FacePainter oldDelegate) {
    return true;
  }
}
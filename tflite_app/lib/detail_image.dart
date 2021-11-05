import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class DetailImage extends StatefulWidget {
  const DetailImage({Key? key, this.path}) : super(key: key);

  final String? path;

  @override
  _DetailImageState createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage> {
  List? _recognitions;

  @override
  void initState() {
    loadModel();
  }

  loadModel() async {
    var result = await Tflite.loadModel(
        // model: "assets/mobilenet_v1_1.0_224.tflite",
        // labels: "assets/mobilenet_v1_1.0_224.txt"
        // model: "assets/ssd_mobilenet.tflite",
        // labels: "assets/ssd_mobilenet.txt"
        model: "assets/model1/lite-model_seefood_segmenter_mobile_food_segmenter_V1_1.tflite",
        labels: "assets/model1/labelmap.txt"
        );

    print("result: ${result}");

    await recognizeImage();
  }

  Future recognizeImage() async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: widget.path!,
      numResults: 2,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
      asynch: false
    );

    // var recognitions = await Tflite.detectObjectOnImage(
    //   model: "MobileNet",
    //   path: widget.path!,
    //   // path: image.path,
    //   numResultsPerClass: 1,
    // );

    setState(() {
      _recognitions = recognitions;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
    print(_recognitions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Details"),
        ),
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              color: Colors.black,
              child: Image.file(
                File(widget.path!),
              ),
            ),
          ],
        )
        // : Container(
        //     color: Colors.black,
        //     child: const Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   ),
        );
  }
}

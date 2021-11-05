import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;

  const DetailScreen({required this.imagePath});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final String _imagePath;
  Size? _imageSize;

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

  loadModel() async {
    var result = await Tflite.loadModel(
      model: "assets/model5/model_unquant.tflite",
      labels: "assets/model5/labels.txt"
    );

    print("result: ${result}");

    await applyModelOnImage();
  }

  applyModelOnImage() async {
    print(widget.imagePath);
    var res = await Tflite.runModelOnImage(
      path: widget.imagePath,
      numResults: 5,
      threshold: 0.2,
      imageMean: 127.5,
      imageStd: 127.5,
      asynch: false
    );
    print("res: ${res}");
  }

  @override
  void initState() {
    _imagePath = widget.imagePath;
    loadModel();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                File(_imagePath),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                elevation: 8,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Identified emails",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        child: SingleChildScrollView(
                          child: _listEmailStrings != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: _listEmailStrings!.length,
                                  itemBuilder: (context, index) =>
                                      Text(_listEmailStrings![index]),
                                )
                              : Container(),
                        ),
                      ),
                    ],
                  ),
                ),
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

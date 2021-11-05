import 'package:camera/camera.dart';
import 'package:camera_app/camera_view.dart';
import 'package:camera_app/video_view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;

  late String path;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: cameraValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CameraPreview(_cameraController),);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        flash ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        setState(() {
                          flash = !flash;
                        });
                        flash ? _cameraController.setFlashMode(FlashMode.torch)
                            : _cameraController.setFlashMode(FlashMode.off);
                      },
                    ),
                    GestureDetector(
                      onLongPress: () async {
                        await _cameraController.startVideoRecording();
                        setState(() {
                          isRecording = true;
                        });
                      },
                      onLongPressUp: () async {
                        var xFile =
                            await _cameraController.stopVideoRecording();
                        path = xFile.path;

                        setState(() {
                          isRecording = false;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (builder) => VideoViewPage(path: path)));
                      },
                      onTap: () {
                        if (!isRecording) takePhoto(context);
                      },
                      child: isRecording
                          ? const Icon(
                              Icons.radio_button_on,
                              color: Colors.red,
                              size: 80,
                            )
                          : const Icon(
                              Icons.panorama_fish_eye,
                              color: Colors.white,
                              size: 70,
                            ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.flip_camera_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () async {
                        setState(() {
                          isCameraFront = !isCameraFront;
                        });
                        int cameraPos = isCameraFront? 0 : 1;
                        _cameraController = CameraController(
                          cameras[cameraPos], ResolutionPreset.high
                        );
                        cameraValue = _cameraController.initialize();
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Hold for video, tap for photo',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void takePhoto(BuildContext context) async {
    // final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile xFile = await _cameraController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(path: xFile.path)));
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'main.dart';

// late String path;
//
// class CreateVid extends StatefulWidget {
//   @override
//   State<CreateVid> createState() => _CreateVidState();
// }
//
// class _CreateVidState extends State<CreateVid> {
//   late CameraController controller;
//   late Future<void> initializeControllerFuture;
//
//   bool isDisabled = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = CameraController(cameras[1], ResolutionPreset.high);
//
//     initializeControllerFuture = controller.initialize();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 Container(
//                   color: Colors.green,
//                   // height: 500,
//                   // width: 500,
//                   alignment: Alignment.center,
//                   child: CameraPreview(
//                     controller,
//                     child: const Text("dsfsgsfsdfsd"),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: !controller.value.isRecordingVideo
//                       ? RawMaterialButton(
//                           onPressed: () async {
//                             try {
//                               await initializeControllerFuture;
//
//                               // path = join(
//                               //     (await getApplicationDocumentsDirectory())
//                               //         .path,
//                               //     '${DateTime.now()}.mp4');
//
//                               setState(() {
//                                 controller.startVideoRecording();
//                                 isDisabled = true;
//                                 isDisabled = !isDisabled;
//                               });
//                             } catch (e) {
//                               print(e);
//                             }
//                           },
//                           child: const Icon(
//                             Icons.camera,
//                             size: 50.0,
//                             color: Colors.yellow,
//                           ),
//                           padding: const EdgeInsets.all(10.0),
//                           shape: const CircleBorder(),
//                         )
//                       : null,
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: controller.value.isRecordingVideo
//                       ? RawMaterialButton(
//                           onPressed: () {
//                             setState(() async {
//                               if (controller.value.isRecordingVideo) {
//                                 XFile videoFile = await controller.stopVideoRecording();
//                                 print(videoFile.path);
//                                 isDisabled = false;
//                                 isDisabled = !isDisabled;
//                               }
//                             });
//                           },
//                           child: const Icon(
//                             Icons.stop,
//                             size: 50.0,
//                             color: Colors.red,
//                           ),
//                           padding: const EdgeInsets.all(10.0),
//                           shape: const CircleBorder(),
//                         )
//                       : null,
//                 )
//               ],
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         });
//   }
// }

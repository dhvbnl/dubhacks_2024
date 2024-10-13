import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _setupCameras();
  }

  Future<void> _setupCameras() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _controller = CameraController(firstCamera, ResolutionPreset.high);
      _initializeControllerFuture = _controller!.initialize();
      setState(() {});
    } catch (e) {}
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String imageID = '${DateTime.now().millisecondsSinceEpoch}.png';
      final String imagePath = '${appDocDir.path}/$imageID';

      XFile picture = await _controller!.takePicture();
      await picture.saveTo(imagePath);
      Navigator.pop(context, imageID);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.black,
      appBar: PlatformAppBar(backgroundColor: Colors.black),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 10.0),
                  child: AspectRatio(
                    aspectRatio: 3.0 / 4.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: ClipRect(
                        child: OverflowBox(
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _controller?.value.previewSize!.height,
                              height: _controller?.value.previewSize!.width,
                              child: CameraPreview(_controller!),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PlatformTextButton(
                    onPressed: () {
                      _takePicture();
                    },
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 40.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                            25.0), // Optional: rounded corners
                        border: Border.all(color: Colors.white),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const SpinKitCircle(
              color: Colors.white,
              duration: Duration(milliseconds: 200),
            );
          }
        },
      ),
    );
  }
}

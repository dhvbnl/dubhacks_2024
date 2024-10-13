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
  late List<CameraDescription> _cameras;

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
    } catch (e) {
      print("error initializing camera: $e");
    }
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Camera',
          style: TextStyle(
            color: Colors.white,
          ),
          ), 
        backgroundColor: Colors.black
      ),
      // Display the camera preview
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [Padding(
                padding: const EdgeInsets.all(10.0),
                
                  child: AspectRatio(
                    aspectRatio: 3.0/4.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
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
              Spacer(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Padding(
            padding: EdgeInsets.all(10.0),
            child: PlatformTextButton(
              onPressed: () {
                _takePicture();
              },
              child: Container(
                width: 80, // Set the width and height to create a square button
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black, // Button background color
                  shape: BoxShape.circle, // Make the button circular
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 40.0, // Adjust the size as needed
                  ),
                ),
              ),
            ),
          ),
              ),
              SizedBox(height: 5.0,)]
            );
           

          } else if (snapshot.hasError) {
            // If there's an error during initialization, display it.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Otherwise, display a loading indicator.
            return SpinKitCircle(
              color: Colors.white,
              duration: Duration(milliseconds: 200),
            );
          }
        },
      ),

    );
  }
}

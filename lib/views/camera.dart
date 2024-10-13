import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

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
    try{
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
      final String imagePath = join(
        appDocDir.path,
        '${DateTime.now().millisecondsSinceEpoch}.png',
      );

      XFile picture = await _controller!.takePicture();
      await picture.saveTo(imagePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Picture saved to $imagePath')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take picture: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      // Display the camera preview
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller!);
          } else if (snapshot.hasError) {
            // If there's an error during initialization, display it.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
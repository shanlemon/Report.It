import "package:flutter/material.dart";
import 'package:camera/camera.dart';

class CrimeView extends StatefulWidget {
  @override
  _CrimeViewState createState() => _CrimeViewState();
}

class _CrimeViewState extends State<CrimeView> {

  CameraController controller;
  List<CameraDescription> cameras;

  Future<List<CameraDescription>> getCameras() {
    
    return availableCameras();

  }

  @override
  void initState() {
    super.initState();

    getCameras()
      .then((List<CameraDescription> s) {
        setState(() {
          cameras = s;
        });
      })
      .then((_) {
        controller = CameraController(cameras[0], ResolutionPreset.high);
        controller.initialize().then((_) {
          if (!mounted) return;

          setState(() {});
        });
      });

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return new AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: new CameraPreview(controller));
  }
}
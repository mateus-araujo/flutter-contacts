import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

class TakePictureView extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureView({Key? key, required this.camera}) : super(key: key);

  @override
  _TakePictureViewState createState() => _TakePictureViewState();
}

class _TakePictureViewState extends State<TakePictureView> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    ImageCrop.requestPermissions();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> takePhoto() async {
    try {
      await _controller.initialize();

      final file = await _controller.takePicture();
      return file.path;
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Imagem'),
      ),
      body: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () {
          takePhoto().then((path) {
            Navigator.pop(context, path);
          });
        },
      ),
    );
  }
}

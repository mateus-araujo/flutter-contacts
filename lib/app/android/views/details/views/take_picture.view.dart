import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TakePictureView extends StatefulWidget {
  @override
  _TakePictureViewState createState() => _TakePictureViewState();
}

class _TakePictureViewState extends State<TakePictureView> {
  final _controller = GetIt.instance.get<CameraController>();

  Future<String> takePhoto() async {
    try {
      await _controller.initialize();
      // _controller.setFlashMode(FlashMode.off);

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

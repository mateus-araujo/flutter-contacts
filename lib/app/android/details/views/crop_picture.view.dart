import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CropPictureView extends StatefulWidget {
  final String path;

  const CropPictureView({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  _CropPictureViewState createState() => _CropPictureViewState();
}

class _CropPictureViewState extends State<CropPictureView> {
  final cropKey = GlobalKey<CropState>();

  Future<String> saveImage() async {
    try {
      final area = cropKey.currentState!.area;
      if (area == null) {
        // cannot crop, widget is not setup
        return "";
      }

      final uuid = Uuid();
      final fileName = '${uuid.v4()}.jpg';
      final directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, fileName);

      final croppedImage = await ImageCrop.cropImage(
        file: File(widget.path),
        area: area,
      );

      final bytes = await croppedImage.readAsBytes();
      final buffer = bytes.buffer;

      File(path).writeAsBytes(
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      );

      return path;
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recortar Imagem"),
      ),
      body: Crop(
        key: cropKey,
        image: FileImage(
          File(widget.path),
        ),
        aspectRatio: 1 / 1,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          saveImage().then((path) {
            Navigator.pop(context, path);
          });
        },
      ),
    );
  }
}

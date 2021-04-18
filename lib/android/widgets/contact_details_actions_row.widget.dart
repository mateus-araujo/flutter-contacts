import 'package:camera/camera.dart';
import 'package:contacts/android/views/crop_picture.view.dart';
import 'package:contacts/android/views/take_picture.view.dart';
import 'package:contacts/core/repositories/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:contacts/core/models/contact.model.dart';

class ContactDetailsActionsRow extends StatefulWidget {
  final ContactModel contact;
  final Function onUpdate;

  const ContactDetailsActionsRow({
    Key? key,
    required this.contact,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _ContactDetailsActionsRowState createState() =>
      _ContactDetailsActionsRowState();
}

class _ContactDetailsActionsRowState extends State<ContactDetailsActionsRow> {
  takePicture() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureView(
          camera: firstCamera,
        ),
      ),
    ).then((path) {
      if (path != null) cropPicture(path);
    });
  }

  cropPicture(path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CropPictureView(
          path: path,
        ),
      ),
    ).then((path) => updateImage(path));
  }

  updateImage(path) async {
    final repository = await ContactRepository.repository;

    repository.updateImage(widget.contact.id!, path).then((_) {
      widget.onUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final circleBorderShape = ElevatedButton.styleFrom(
      shape: CircleBorder(
        side: BorderSide.none,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => launch("tel://+55 ${widget.contact.phone}"),
          style: circleBorderShape,
          child: Icon(
            Icons.phone,
            color: Theme.of(context).accentColor,
          ),
        ),
        ElevatedButton(
          onPressed: () => launch("mailto://${widget.contact.email}"),
          style: circleBorderShape,
          child: Icon(
            Icons.email,
            color: Theme.of(context).accentColor,
          ),
        ),
        ElevatedButton(
          onPressed: takePicture,
          style: circleBorderShape,
          child: Icon(
            Icons.camera_enhance,
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}

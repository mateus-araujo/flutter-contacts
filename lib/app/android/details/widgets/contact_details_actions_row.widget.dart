import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/domain/entities/contact.dart';

import '../views/crop_picture.view.dart';
import '../views/take_picture.view.dart';

class ContactDetailsActionsRow extends StatefulWidget {
  final Contact contact;
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
  final _repository = GetIt.instance.get<ContactRepository>();

  takePicture() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureView(),
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
    _repository.updateImage(widget.contact.id!, path).then((_) {
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

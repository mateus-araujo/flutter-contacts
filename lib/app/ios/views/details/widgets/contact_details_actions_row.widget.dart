import 'package:flutter/cupertino.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/domain/entities/contact.dart';

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
  final _repository = BindingService.get<ContactRepository>();

  takePicture() async {
    NavigationService.pushNamed(Routes.takePicture).then((path) {
      print(path);
      if (path != null) cropPicture(path as List<String?>);
    });
  }

  cropPicture(List<String?> path) {
    NavigationService.pushNamed(
      Routes.cropPicture,
      arguments: {'path': path},
    ).then((path) => updateImage(path as List<String?>));
  }

  updateImage(List<String?> path) async {
    if (path[0]!.isEmpty) {
      return;
    }

    _repository.updateImage(widget.contact.id!, path[0]!).then((_) {
      widget.onUpdate();
    });
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CupertinoButton(
          onPressed: () => _launchURL("tel://+55 ${widget.contact.phone}"),
          child: Icon(
            CupertinoIcons.phone,
          ),
        ),
        CupertinoButton(
          onPressed: () => _launchURL("mailto://${widget.contact.email}"),
          child: Icon(
            CupertinoIcons.mail,
          ),
        ),
        CupertinoButton(
          onPressed: takePicture,
          child: Icon(
            CupertinoIcons.photo_camera,
          ),
        ),
      ],
    );
  }
}

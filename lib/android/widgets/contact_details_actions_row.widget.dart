import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:contacts/core/models/contact.model.dart';

class ContactDetailsActionsRow extends StatelessWidget {
  final ContactModel contact;

  const ContactDetailsActionsRow({Key? key, required this.contact})
      : super(key: key);

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
          onPressed: () => launch("tel://+55 ${contact.phone}"),
          style: circleBorderShape,
          child: Icon(
            Icons.phone,
            color: Theme.of(context).accentColor,
          ),
        ),
        ElevatedButton(
          onPressed: () => launch("mailto://${contact.email}"),
          style: circleBorderShape,
          child: Icon(
            Icons.email,
            color: Theme.of(context).accentColor,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
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

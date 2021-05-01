import 'dart:io';

import 'package:contacts/app/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:contacts/domain/entities/contact.dart';

class ContactListItem extends StatelessWidget {
  final Contact model;

  const ContactListItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: model.image == null
          ? CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile-picture.png'))
          : CircleAvatar(
              backgroundImage: FileImage(
                File(model.image!),
              ),
            ),
      title: Text(model.name!),
      subtitle: Text(model.phone!),
      trailing: TextButton(
        onPressed: () {
          if (model.id != null) {
            Navigator.pushNamed(
              context,
              Routes.details,
              arguments: {'id': model.id},
            );
          }
        },
        child: Icon(Icons.person),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
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
            NavigationService.pushNamed(
              Routes.contact,
              arguments: {'id': model.id},
            );
          }
        },
        child: Icon(Icons.person),
      ),
    );
  }
}

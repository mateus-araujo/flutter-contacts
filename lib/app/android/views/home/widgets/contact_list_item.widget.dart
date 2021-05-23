import 'dart:io';

import 'package:flutter/material.dart';

import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/domain/entities/contact.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  const ContactListItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: contact.image == null
          ? CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile-picture.png'))
          : CircleAvatar(
              backgroundImage: FileImage(
                File(contact.image!),
              ),
            ),
      title: Text(contact.name!),
      subtitle: Text(contact.phone!),
      trailing: TextButton(
        onPressed: () {
          if (contact.id != null) {
            NavigationService.pushNamed(
              Routes.contact,
              arguments: {'id': contact.id},
            );
          }
        },
        child: Icon(Icons.person),
      ),
    );
  }
}

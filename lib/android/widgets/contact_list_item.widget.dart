import 'dart:io';

import 'package:contacts/core/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:contacts/android/views/details.view.dart';
import 'package:contacts/core/models/contact.model.dart';

class ContactListItem extends StatelessWidget {
  final HomeController controller;
  final ContactModel model;

  const ContactListItem({
    Key? key,
    required this.model,
    required this.controller,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsView(
                  id: model.id ?? 0,
                  controller: controller,
                ),
              ),
            );
          }
        },
        child: Icon(Icons.person),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:contacts/android/views/details.view.dart';
import 'package:contacts/core/models/contact.model.dart';

class ContactListItem extends StatelessWidget {
  final ContactModel model;

  const ContactListItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: model.image == null
                ? AssetImage("assets/images/profile-picture.png")
                : AssetImage(model.image!),
          ),
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

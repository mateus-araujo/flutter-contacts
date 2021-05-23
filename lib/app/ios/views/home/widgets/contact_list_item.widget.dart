import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:contacts/app/ios/styles.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            image: contact.image == null
                ? DecorationImage(
                    image: AssetImage('assets/images/profile-picture.png'))
                : DecorationImage(
                    image: FileImage(
                      File(contact.image!),
                    ),
                  ),
            borderRadius: BorderRadius.circular(48),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  contact.name!,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  contact.phone!,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        CupertinoButton(
          child: Icon(
            CupertinoIcons.person,
            color: primaryColor,
          ),
          onPressed: () {
            if (contact.id != null) {
              NavigationService.pushNamed(
                Routes.contact,
                arguments: {'id': contact.id},
              );
            }
          },
        ),
      ],
    );
  }
}
